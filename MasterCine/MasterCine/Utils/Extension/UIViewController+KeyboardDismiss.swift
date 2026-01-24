//
//  UIViewController+KeyboardDismiss.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

public extension UIViewController {
  /// Enable dismissal of the keyboard by tapping anywhere outside input fields.
  ///
  /// Usage: call in `viewDidLoad()`:
  /// `enableKeyboardDismissOnTap()`
  ///
  /// - Parameters:
  ///   - cancelsTouchesInView: If `true`, the tap will prevent the touch from reaching subviews.
  ///     Keep `false` for most cases (buttons/scrolls still work).
  ///   - ignoredViewTypes: View types that should NOT trigger keyboard dismissal when tapped.
  ///     Defaults to UI controls and editable text views.
  func enableKeyboardDismissOnTap(
    cancelsTouchesInView: Bool = false,
    ignoredViewTypes: [UIView.Type] = [UIControl.self, UITextView.self]
  ) {
    // Avoid adding multiple recognizers of the same type
    if let recognizers = view.gestureRecognizers,
       recognizers.contains(where: { $0 is KeyboardDismissTapGestureRecognizer }) {
      return
    }

    let tap = KeyboardDismissTapGestureRecognizer(
      ignoredViewTypes: ignoredViewTypes,
      target: self,
      action: #selector(handleKeyboardDismissTap)
    )

    tap.cancelsTouchesInView = cancelsTouchesInView
    tap.numberOfTapsRequired = 1

    view.addGestureRecognizer(tap)
  }

  @objc private func handleKeyboardDismissTap() {
    view.endEditing(true)
  }
}

private final class KeyboardDismissTapGestureRecognizer: UITapGestureRecognizer, UIGestureRecognizerDelegate {

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
