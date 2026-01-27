//
//  TMDbServiceProtocol.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

import Foundation

protocol TMDbServiceProtocol {
  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void)
  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void)
  func makePosterURL(path: String?) -> URL?
}

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case httpStatus(Int)
  case decoding
  case transport(Error)

  var userMessage: String {
    switch self {
    case .invalidURL:
      return "URL inválida."
    case .invalidResponse:
      return "Resposta inválida."
    case .httpStatus(let code):
      return "Erro na API. Status: \(code)."
    case .decoding:
      return "Falha ao processar os dados."
    case .transport:
      return "Falha de conexão."
    }
  }
}

final class TMDbService: TMDbServiceProtocol {

  private let session = URLSession(configuration: .default)
  private let apiKey = TMDbConfig.apiKey
  private let baseURL = URL(string: "https://api.themoviedb.org/3")!
  private let imageBaseURL = URL(string: "https://image.tmdb.org/t/p")!

  func fetchPopular(page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
    request(
      path: "/movie/popular",
      queryItems: [
        URLQueryItem(name: "page", value: "\(page)")
      ],
      completion: completion
    )
  }

  func search(query: String, page: Int, completion: @escaping (Result<MovieResponse, NetworkError>) -> Void) {
    request(
      path: "/search/movie",
      queryItems: [
        URLQueryItem(name: "query", value: query),
        URLQueryItem(name: "page", value: "\(page)"),
        URLQueryItem(name: "include_adult", value: "false")
      ],
      completion: completion
    )
  }

  func makePosterURL(path: String?) -> URL? {
    guard let path, !path.isEmpty else { return nil }
    return imageBaseURL
      .appendingPathComponent("w342")
      .appendingPathComponent(path)
  }

  private func request<T: Decodable>(
    path: String,
    queryItems: [URLQueryItem],
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    var components = URLComponents(
      url: baseURL.appendingPathComponent(path),
      resolvingAgainstBaseURL: false
    )

    var items = queryItems
    items.append(URLQueryItem(name: "api_key", value: apiKey))
    items.append(URLQueryItem(name: "language", value: "pt-BR"))
    components?.queryItems = items

    guard let url = components?.url else {
      DispatchQueue.main.async { completion(.failure(.invalidURL)) }
      return
    }

    let request = URLRequest(url: url)
    let startTime = Date()

    session.dataTask(with: request) { data, response, error in

      NetworkLogger.log(
        request: request,
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

enum TMDbConfig {
  static let apiKey = "c892a7d14f1039dde2aab253840f4855"
}
