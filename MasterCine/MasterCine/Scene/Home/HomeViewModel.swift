//
//  HomeViewModelDelegate.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
  func didUpdate()
  func didFail(message: String)
  func didChangeLoading(isLoading: Bool)
}

final class HomeViewModel {

  weak var delegate: HomeViewModelProtocol?

  private let service: TMDbServiceProtocol = TMDbService()
  private var movies: [Movie] = []

  private var lastPerformedQuery: String = ""
  private var isShowingPopular: Bool = false

  var numberOfItems: Int { movies.count }
  var isEmpty: Bool { movies.isEmpty }

  func search(text: String) {
    let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

    if query.isEmpty {
      fetchPopularIfNeeded()
      return
    }

    let normalized = query.lowercased()
    let lastNormalized = lastPerformedQuery.lowercased()

    guard normalized != lastNormalized else { return }

    lastPerformedQuery = query
    isShowingPopular = false
    searchMovies(query: query)
  }

  func loudCurrentMovie(at index: Int) -> Movie {
    movies[index]
  }

  func fetchPopularIfNeeded() {
    guard !isShowingPopular else { return }
    isShowingPopular = true
    lastPerformedQuery = ""
    fetchPopular()
  }

  private func fetchPopular() {
    setLoading(true)
    service.fetchPopular(page: 1) { [weak self] result in
      guard let self else { return }
      self.setLoading(false)
      switch result {
      case .success(let response):
        self.movies = response.results
        self.delegate?.didUpdate()
      case .failure(let error):
        self.delegate?.didFail(message: error.userMessage)
      }
    }
  }

  private func searchMovies(query: String) {
    setLoading(true)
    service.search(query: query, page: 1) { [weak self] result in
      guard let self else { return }
      self.setLoading(false)
      switch result {
      case .success(let response):
        self.movies = response.results
        self.delegate?.didUpdate()
      case .failure(let error):
        self.delegate?.didFail(message: error.userMessage)
      }
    }
  }

  private func setLoading(_ isLoading: Bool) {
    delegate?.didChangeLoading(isLoading: isLoading)
  }
}
