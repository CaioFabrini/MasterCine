//
//  ImageLoader.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import UIKit

final class ImageLoader {

  static let shared = ImageLoader()

  private init() {}

  func load(
    url: URL?,
    into imageView: UIImageView,
    errorImage: UIImage? = nil,
    showsLoading: Bool = true
  ) {
    imageView.image = nil
    imageView.accessibilityIdentifier = url?.absoluteString

    guard let url else {
      imageView.image = errorImage
      return
    }

    if let cached = ImageCache.shared.image(for: url) {
      imageView.image = cached
      return
    }

    let spinner = showsLoading ? showSpinner(in: imageView) : nil

    ImageService.shared.download(from: url) { result in
      spinner?.removeFromSuperview()

      guard imageView.accessibilityIdentifier == url.absoluteString else {
        return
      }

      switch result {
      case .success(let image):
        ImageCache.shared.save(image, for: url)
        imageView.image = image

      case .failure:
        imageView.image = errorImage
      }
    }
  }

  private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(spinner)

    NSLayoutConstraint.activate([
      spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    spinner.startAnimating()
    return spinner
  }
}
