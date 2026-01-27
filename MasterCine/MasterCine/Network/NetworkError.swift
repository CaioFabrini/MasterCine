//
//  NetworkError.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

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
