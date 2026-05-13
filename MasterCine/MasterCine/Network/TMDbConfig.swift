//
//  TMDbConfig.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

struct TMDbConfig {
  static let posterSize = "w342"

  static var apiKey: String {
    guard let key = Bundle.main.infoDictionary?["APIKey"] as? String else {
      fatalError("APIKey não encontrada no Info.plist")
    }
    return key
  }

  static var baseURLString: String {
    guard let url = Bundle.main.infoDictionary?["BaseURL"] as? String else {
      fatalError("BaseURL não encontrada no Info.plist")
    }
    return url
  }

  static var imageBaseURLString: String {
    guard let url = Bundle.main.infoDictionary?["ImageBaseURL"] as? String else {
      fatalError("ImageBaseURL não encontrada no Info.plist")
    }
    return url
  }

  static var baseURL: URL? { URL(string: baseURLString) }
}
