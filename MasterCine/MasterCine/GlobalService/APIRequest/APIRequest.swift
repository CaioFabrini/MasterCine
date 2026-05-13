//
//  APIRequest.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 13/04/26.
//

import Foundation

struct APIRequest {
  let endpoint: String
  let httpMethod: HTTPMethod
  let headers: [String: String]?
  let parameters: Parameters?

  init(endpoint: String,
       httpMethod: HTTPMethod = .get,
       headers: [String : String]? = nil,
       parameters: Parameters? = nil) {
    self.endpoint = endpoint
    self.httpMethod = httpMethod
    self.headers = headers
    self.parameters = parameters
  }
}

