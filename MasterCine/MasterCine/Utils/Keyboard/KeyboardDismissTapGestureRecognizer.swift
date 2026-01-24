//
//  KeyboardDismissTapGestureRecognizer.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class KeyboardDismissTapGestureRecognizer: UITapGestureRecognizer, UIGestureRecognizerDelegate {

  private let ignoredViewTypes: [UIView.Type]

  init(ignoredViewTypes: [UIView.Type], target: Any?, action: Selector?) {
    self.ignoredViewTypes = ignoredViewTypes
    super.init(target: target, action: action)
    delegate = self
  }

  // Do not recognize tap if it's on an interactive control that handles its own touches (e.g., inside a UIControl)
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    guard let touchedView = touch.view else { return true }

    let hierarchy = sequence(first: touchedView) { $0.superview }

    let isIgnored = hierarchy.contains { view in
      ignoredViewTypes.contains { view.isKind(of: $0) }
    }

    return !isIgnored
  }
}
