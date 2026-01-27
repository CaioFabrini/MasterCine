//
//  ImageRequestService.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import UIKit

final class ImageService {

  static let shared = ImageService()

  private let session = URLSession(configuration: .default)

  private init() {}

  func download(
    from url: URL,
    completion: @escaping (Result<UIImage, Error>) -> Void
  ) {
    session.dataTask(with: url) { data, response, error in
      if let error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }

      guard
        let http = response as? HTTPURLResponse,
        (200...299).contains(http.statusCode),
        let data,
        let image = UIImage(data: data)
      else {
        DispatchQueue.main.async {
          completion(.failure(URLError(.badServerResponse)))
        }
        return
      }

      DispatchQueue.main.async {
        completion(.success(image))
      }
    }.resume()
  }
}
