//
//  UILabel+Extension.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

extension UILabel {

  var isTextTruncated: Bool {
    guard let text = text else { return false }

    let size = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)

    let attributes: [NSAttributedString.Key: Any] = [
      .font: font as Any
    ]

    let boundingRect = (text as NSString).boundingRect(
      with: size,
      options: [.usesLineFragmentOrigin],
      attributes: attributes,
      context: nil
    )

    return boundingRect.height > bounds.height
  }
}
