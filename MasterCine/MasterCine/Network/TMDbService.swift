//
//  TMDbServiceProtocol.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

protocol TMDbServiceProtocol {
  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError2>) -> Void)
  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError2>) -> Void)
  func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetailResponse, NetworkError2>) -> Void)
}

final class TMDbService: TMDbServiceProtocol {

  private let client: NetworkClientProtocol
  private let apiKey: String
  private let baseURL: URL

  init(
    client: NetworkClientProtocol = NetworkClient(),
    apiKey: String = TMDbConfig.apiKey,
    baseURL: URL? = TMDbConfig.baseURL
  ) {
    self.client = client
    self.apiKey = apiKey
    self.baseURL = baseURL ?? URL(fileURLWithPath: "/")
  }

  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError2>) -> Void) {
    guard baseURL.scheme != nil else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    client.request(
      baseURL: baseURL,
      path: "/movie/popular",
      queryItems: defaultQueryItems(extra: [
        URLQueryItem(name: "page", value: "\(page)")
      ]),
      completion: completion
    )
  }

  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError2>) -> Void) {
    guard baseURL.scheme != nil else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    client.request(
      baseURL: baseURL,
      path: "/search/movie",
      queryItems: defaultQueryItems(extra: [
        URLQueryItem(name: "query", value: query),
        URLQueryItem(name: "page", value: "\(page)"),
        URLQueryItem(name: "include_adult", value: "false")
      ]),
      completion: completion
    )
  }

  func fetchMovieDetail(
    id: Int,
    completion: @escaping (Result<MovieDetailResponse, NetworkError2>) -> Void
  ) {
    guard baseURL.scheme != nil else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    client.request(
      baseURL: baseURL,
      path: "/movie/\(id)",
      queryItems: defaultQueryItems(extra: [
        URLQueryItem(name: "append_to_response", value: "credits,videos,recommendations")
      ]),
      completion: completion
    )
  }

  private func defaultQueryItems(extra: [URLQueryItem]) -> [URLQueryItem] {
    var items = extra
    items.append(URLQueryItem(name: "api_key", value: apiKey))
    items.append(URLQueryItem(name: "language", value: "pt-BR"))
    return items
  }
}
