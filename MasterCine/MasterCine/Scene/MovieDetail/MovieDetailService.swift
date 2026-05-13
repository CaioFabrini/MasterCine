//
//  MovieDetailService.swift
//  MasterCine
//
//  Created by Caio Fabrini on 22/04/26.
//

import Foundation

protocol MovieDetailServiceProtocol {
  func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetailResponse, NetworkError>) -> Void)
}

final class MovieDetailService: MovieDetailServiceProtocol {

  private let client: APIClient

  init(client: APIClient = APIClient.shared) {
    self.client = client
  }

  func fetchMovieDetail(id: Int, completion: @escaping (Result<MovieDetailResponse, NetworkError>) -> Void) {
    let request = APIRequest(
      endpoint: "/movie/\(id)?append_to_response=credits,videos,recommendations",
      httpMethod: .get
    )

    client.request(request: request, decodeType: MovieDetailResponse.self, completion: completion)
  }
}
