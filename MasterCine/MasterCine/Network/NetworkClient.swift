//
//  NetworkClientProtocol.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

protocol NetworkClientProtocol {
  func request<T: Decodable>(
    baseURL: URL,
    path: String,
    queryItems: [URLQueryItem],
    completion: @escaping (Result<T, NetworkError>) -> Void
  )
}

final class NetworkClient: NetworkClientProtocol {

  private let session: URLSession

  init(session: URLSession = URLSession(configuration: .default)) {
    self.session = session
  }

  func request<T: Decodable>(
    baseURL: URL,
    path: String,
    queryItems: [URLQueryItem],
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    var components = URLComponents(
      url: baseURL.appendingPathComponent(path),
      resolvingAgainstBaseURL: false
    )
    components?.queryItems = queryItems

    guard let url = components?.url else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    let urlRequest = URLRequest(url: url)
    let startTime = Date()

    session.dataTask(with: urlRequest) { data, response, error in
      NetworkLogger.log(
        request: urlRequest,
        response: response,
        data: data,
        error: error,
        startTime: startTime
      )

      if let error {
        DispatchQueue.main.async { completion(.failure(.transport(error))) }
        return
      }

      guard let http = response as? HTTPURLResponse else {
        DispatchQueue.main.async { completion(.failure(.invalidResponse)) }
        return
      }

      guard (200...299).contains(http.statusCode) else {
        DispatchQueue.main.async { completion(.failure(.httpStatus(http.statusCode))) }
        return
      }

      guard let data else {
        DispatchQueue.main.async { completion(.failure(.invalidResponse)) }
        return
      }

      do {
        let decoded = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async { completion(.success(decoded)) }
      } catch {
        DispatchQueue.main.async { completion(.failure(.decoding)) }
      }
    }.resume()
  }
}
