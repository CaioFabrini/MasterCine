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


  func topMostViewController() -> UIViewController {
    var top = self

    while let presented = top.presentedViewController {
      top = presented
    }

    if let nav = top as? UINavigationController {
      return nav.visibleViewController ?? nav
    }

    if let tab = top as? UITabBarController {
      return tab.selectedViewController ?? tab
    }

    return top
  }

  func showAlert(
    title: String = "Ops!",
    message: String,
    buttonTitle: String = "OK",
    completion: (() -> Void)? = nil
  ) {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }

      let topVC = self.topMostViewController()

      if let presentedAlert = topVC.presentedViewController as? UIAlertController {
        presentedAlert.title = title
        presentedAlert.message = message
        return
      }

      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

      let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
        completion?()
      }

      alert.addAction(okAction)
      topVC.present(alert, animated: true)
    }
  }

  func showError(message: String) {
    showAlert(title: "Erro", message: message)
  }
}
