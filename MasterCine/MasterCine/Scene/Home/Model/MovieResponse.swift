//
//  MovieResponse.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

struct MovieResponse: Codable, Equatable {
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int

  enum CodingKeys: String, CodingKey {
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

struct Movie: Codable, Equatable {
  let id: Int
  let title: String
  let posterPath: String?
  let releaseDate: String?
  let voteAverage: Double?

  var urlImage: String? {
    guard let posterPath, !posterPath.isEmpty else { return nil }
    return "\(TMDbConfig.imageBaseURLString)/\(TMDbConfig.posterSize)\(posterPath)"
  }

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
  }
}
