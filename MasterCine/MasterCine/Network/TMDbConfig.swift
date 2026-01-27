//
//  TMDbConfig.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

struct TMDbConfig {
  static let apiKey = "c892a7d14f1039dde2aab253840f4855"

  static let baseURLString = "https://api.themoviedb.org/3"
  static let imageBaseURLString = "https://image.tmdb.org/t/p"
  static let posterSize = "w342"

  static var baseURL: URL? { URL(string: baseURLString) }
  static var imageBaseURL: URL? { URL(string: imageBaseURLString) }
}
