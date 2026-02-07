//
//  UIApplication+KeyWindow.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

extension UIApplication {
  static var mc_primaryKeyWindow: UIWindow? {
    // For iOS 13 and later, get the key window from connected scenes
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first(where: { $0.isKeyWindow })
  }
}
