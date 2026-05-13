//
//  HomeService.swift
//  MasterCine
//
//  Created by Caio Fabrini on 20/04/26.
//

import Foundation

protocol HomeServiceProtocol {
  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void)
  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void)
}

final class HomeService: HomeServiceProtocol {

  private let client: APIClient

  init(client: APIClient = APIClient.shared) {
    self.client = client
  }

  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
    let request = APIRequest(
      endpoint: "/movie/popular?page=\(page)",
      httpMethod: .get
    )

    client.request(request: request, decodeType: MovieResponse.self, completion: completion)
  }

  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
    let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
    let request = APIRequest(
      endpoint: "/search/movie?query=\(encoded)&page=\(page)&include_adult=false",
      httpMethod: .get
    )

    client.request(request: request, decodeType: MovieResponse.self, completion: completion)
  }
}
