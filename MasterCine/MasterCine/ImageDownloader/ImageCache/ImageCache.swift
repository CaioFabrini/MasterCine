//
//  ImageCache.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 16/04/26.
//

import Foundation
import UIKit

final class ImageCache {
  
  static let shared = ImageCache()
  private let cache = NSCache<NSString, UIImage>()
  
  private init() {}
  
  func save(image: UIImage, key: String) {
    cache.setObject(image, forKey: key as NSString)
  }
  
  func get(key: String) -> UIImage? {
    return cache.object(forKey: key as NSString)
  }
  
  // Desse modo vai funcionar também, pois o Swift sabe que por você ter 1 única linha, aquilo que voce colocou é o retorno
  //  func get(key: String) -> UIImage? {
  //    cache.object(forKey: key as NSString)
  //  }
  
  func remove(key: String) {
    return cache.removeObject(forKey: key as NSString)
  }
  
  func removeAll() {
    cache.removeAllObjects()
  }
}
