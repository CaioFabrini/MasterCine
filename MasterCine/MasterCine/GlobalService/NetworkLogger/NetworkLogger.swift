//
//  NetworkLogger.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 16/04/26.
//

import Foundation

struct NetworkLogger {
  static func log(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) {
    print("------------------- 🚀 START OF REQUEST 🚀 -------------------")
    print(" ")
    print("📤 REQUEST:")
    requestInfo(request: request)
    print("--------------------------------------------------------------")
    print(" ")
    print("📥 RESPONSE:")
    responseInfo(response: response, error: error)
    responseData(data: data)
    print("--------------------------------------------------------------")
    print(" ")
    print("-------------------- 🚀 END OF REQUEST 🚀 --------------------")
  }

  static func logDecodingError<T: Decodable>(error: Error, type: T.Type) {
    print("🚨 Start Decoding Error 🚨")
    print("Failed Type: \(String(describing: type))")
    print("Reason: \(error.localizedDescription)")
    print("🚨  Stop Decoding Error 🚨")
  }
}

extension NetworkLogger {
  static private func requestInfo(request: URLRequest) {
    if let url = request.url?.absoluteString {
      print("Request URL: \(url)")
    }

    if let method = request.httpMethod {
      print("Request Method: \(method)")
    }

    if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
      print("HEADERS:")
      for value in headers {
        print("   • \(value.key): \(value.value)")
      }
    }

    if let body = request.httpBody,
       let bodyString = prettyPrintedJSON(data: body) {
      print("Request Body: \n\(bodyString)")
    }
  }

  static private func responseInfo(response: URLResponse?, error: Error?) {
    if let response = response as? HTTPURLResponse {
      let statusIcon = (200...299).contains(response.statusCode) ? "✅" : "❌"
      print("Response Status Code: \(response.statusCode) \(statusIcon)")
      return
    }

    if let error {
      print("Error: \(error.localizedDescription)")
    }
  }

  static private func responseData(data: Data?) {
    guard let data else {
      print("Response Data: No data found")
      return
    }

    if let jsonString = prettyPrintedJSON(data: data) {
      print("JSON Response: \n\(jsonString)")
    } else if let string = String(data: data, encoding: .utf8) {
      print("Raw Response: \n\(string)")
    } else {
      print("Data not found")
    }
  }

  static private func prettyPrintedJSON(data: Data) -> String? {
    do {
      let jsonObject = try JSONSerialization.jsonObject(with: data)
      let jsonData   = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8)
    } catch {
      return nil
    }
  }
}
