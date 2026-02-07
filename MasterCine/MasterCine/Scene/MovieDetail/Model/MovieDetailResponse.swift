//
//  MovieDetailResponse.swift
//  MasterCine
//
//  Created by Caio Fabrini on 28/01/26.
//

import Foundation

struct MovieDetailResponse: Decodable, Equatable {
  let id: Int
  let title: String
  let overview: String?
  let runtime: Int?
  let releaseDate: String?
  let voteAverage: Double?
  let posterPath: String?
  let backdropPath: String?
  let genres: [Genre]
  let credits: Credits?
  let videos: Videos?
  let recommendations: Recommendations?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case runtime
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case genres
    case credits
    case videos
    case recommendations
  }

  var posterURL: URL? {
    guard let posterPath, !posterPath.isEmpty, let base = TMDbConfig.imageBaseURL else { return nil }
    return base.appendingPathComponent(TMDbConfig.posterSize).appendingPathComponent(posterPath)
  }

  var backdropURL: URL? {
    guard let backdropPath, !backdropPath.isEmpty, let base = TMDbConfig.imageBaseURL else { return nil }
    return base.appendingPathComponent("w780").appendingPathComponent(backdropPath)
  }
}

struct Genre: Decodable, Equatable {
  let id: Int
  let name: String
}

struct Credits: Decodable, Equatable {
  let cast: [CastMember]
}

struct CastMember: Decodable, Equatable {
  let id: Int
  let name: String
  let character: String?
  let profilePath: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case character
    case profilePath = "profile_path"
  }

  var profileURL: URL? {
    guard let profilePath, !profilePath.isEmpty, let base = TMDbConfig.imageBaseURL else { return nil }
    return base.appendingPathComponent("w185").appendingPathComponent(profilePath)
  }
}

struct Videos: Decodable, Equatable {
  let results: [VideoItem]
}

struct VideoItem: Decodable, Equatable {
  let key: String
  let site: String
  let type: String

  var isYouTubeTrailer: Bool {
    site.lowercased() == "youtube" && type.lowercased() == "trailer"
  }
}

struct Recommendations: Decodable, Equatable {
  let page: Int
  let results: [MovieSummary]
}

struct MovieSummary: Decodable, Equatable {

  let id: Int
  let title: String
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath = "poster_path"
  }

  var posterURL: URL? {
    guard
      let posterPath,
      !posterPath.isEmpty,
      let base = TMDbConfig.imageBaseURL
    else { return nil }

    return base
      .appendingPathComponent(TMDbConfig.posterSize)
      .appendingPathComponent(posterPath)
  }
}
