//
//  MovieDetailViewModel.swift
//  MasterCine
//
//  Created by Caio Fabrini on 28/01/26.
//

import UIKit

enum MovieDetailRow {
  case header(HeaderViewData)
  case actions(ActionsViewData)
  case overview(OverviewViewData)
  case genres(GenresViewData)
  case cast(CastViewData)
  case recommendations(RecommendationsViewData)
  case error(message: String)
}

protocol MovieDetailViewModelProtocol: AnyObject {
  func didUpdate()
  func didChangeLoading(isLoading: Bool)
}

final class MovieDetailViewModel {

  weak var delegate: MovieDetailViewModelProtocol?

  private let service: TMDbServiceProtocol
  private let movieId: Int

  private var rows: [MovieDetailRow] = []

  init(movieId: Int, service: TMDbServiceProtocol = TMDbService()) {
    self.movieId = movieId
    self.service = service
  }

  func fetch() {
    delegate?.didChangeLoading(isLoading: true)

    service.fetchMovieDetail(id: movieId) { [weak self] result in
      guard let self else { return }

      delegate?.didChangeLoading(isLoading: false)

      switch result {
      case .success(let response):
        rows = buildRows(using: response)
        delegate?.didUpdate()

      case .failure(let error):
        rows = [.error(message: error.userMessage)]
        delegate?.didUpdate()
      }
    }
  }

  var numberOfRows: Int {
    rows.count
  }

  func row(at indexPath: IndexPath) -> MovieDetailRow {
    rows[indexPath.row]
  }
}

extension MovieDetailViewModel {
  private func buildRows(using response: MovieDetailResponse) -> [MovieDetailRow] {

    var result: [MovieDetailRow] = []

    let header = HeaderViewData(
      title: response.title,
      subtitle: buildSubtitle(response),
      posterURL: response.posterURL,
      backdropURL: response.backdropURL
    )
    result.append(.header(header))

    let trailerURL = youtubeTrailerURL(from: response.videos)
    result.append(.actions(ActionsViewData(trailerURL: trailerURL, isFavorite: false)))

    let overviewText = (response.overview ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    if !overviewText.isEmpty {
      result.append(.overview(OverviewViewData(text: overviewText)))
    }

    let genres = response.genres.map(\.name).filter { !$0.isEmpty }
    if !genres.isEmpty {
      result.append(.genres(GenresViewData(genres: genres)))
    }

    let cast = response.credits?.cast ?? []
    if !cast.isEmpty {
      result.append(.cast(CastViewData(cast: cast)))
    }

    let recs = response.recommendations?.results ?? []
    if !recs.isEmpty {
      result.append(.recommendations(RecommendationsViewData(movies: recs)))
    }

    return result
  }

  private func buildSubtitle(_ detail: MovieDetailResponse) -> String {

    let year = releaseYear(from: detail.releaseDate)
    let runtime = runtimeText(from: detail.runtime)
    let rating = ratingText(from: detail.voteAverage)

    return [year, runtime, rating]
      .filter { !$0.isEmpty }
      .joined(separator: " • ")
  }

  private func releaseYear(from date: String?) -> String {
    guard let date, date.count >= 4 else { return "" }
    return String(date.prefix(4))
  }

  private func runtimeText(from runtime: Int?) -> String {
    guard let runtime, runtime > 0 else { return "" }
    return "\(runtime) min"
  }

  private func ratingText(from vote: Double?) -> String {
    guard let vote else { return "" }
    return String(format: "⭐️ %.1f", vote)
  }

  private func youtubeTrailerURL(from videos: Videos?) -> URL? {
    guard let video = videos?.results.first(where: { $0.isYouTubeTrailer }) else { return nil }
    return URL(string: "https://www.youtube.com/watch?v=\(video.key)")
  }
}
