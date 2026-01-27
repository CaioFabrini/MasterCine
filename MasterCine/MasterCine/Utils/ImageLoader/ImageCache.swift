//
//  ImageCache.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import UIKit

final class ImageCache {

  static let shared = ImageCache()

  private let cache = NSCache<NSString, UIImage>()

  private init() {
    cache.countLimit = 400
    cache.totalCostLimit = 120 * 1024 * 1024
  }

  func image(for url: URL) -> UIImage? {
    cache.object(forKey: url.absoluteString as NSString)
  }

  func save(_ image: UIImage, for url: URL) {
    cache.setObject(
      image,
      forKey: url.absoluteString as NSString,
      cost: imageCost(image)
    )
  }

  private func imageCost(_ image: UIImage) -> Int {
    let scale = image.scale
    let width = Int(image.size.width * scale)
    let height = Int(image.size.height * scale)
    return width * height * 4
  }
}
