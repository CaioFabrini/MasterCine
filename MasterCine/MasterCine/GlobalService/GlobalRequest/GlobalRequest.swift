//
//  GlobalRequest.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 13/04/26.
//

import Foundation

protocol GlobalRequest {
  func request(apiRequest: APIRequest, baseURL: String, timeout: TimeInterval) -> URLRequest?
}

struct DefaultRequest: GlobalRequest {
  func request(apiRequest: APIRequest, baseURL: String, timeout: TimeInterval) -> URLRequest? {
    let urlString = baseURL + apiRequest.endpoint
    guard var components = URLComponents(string: urlString) else { return nil }

    var items = components.queryItems ?? []
    items.append(URLQueryItem(name: "api_key", value: apiKey))
    items.append(URLQueryItem(name: "language", value: "pt-BR"))
    components.queryItems = items

    guard let url = components.url else { return nil }

    var request = URLRequest(url: url)
    request.httpMethod = apiRequest.httpMethod.rawValue
    request.timeoutInterval = timeout
    request.allHTTPHeaderFields = apiRequest.headers

    if let parameters = apiRequest.parameters {
      switch parameters {
      case .encodable(let encodable):
        request.httpBody = try? JSONEncoder().encode(encodable)
      case .dictionary(let dictionary):
        request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
      }
    }

   return request
  }

  private var apiKey: String {
    guard let key = Bundle.main.infoDictionary?["APIKey"] as? String else {
      fatalError("APIKey não encontrada no Info.plist")
    }
    return key
  }
}
