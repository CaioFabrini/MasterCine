//
//  Loading.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class Loading: UIView {

  static let shared = Loading()

  private lazy var blurView: UIVisualEffectView = {
    let effect = UIBlurEffect(style: .systemChromeMaterialDark)
    let view = UIVisualEffectView(effect: effect)
    view.isUserInteractionEnabled = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var containerView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.92)
    v.layer.cornerRadius = 14
    v.layer.masksToBounds = true
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()

  private lazy var activityIndicator: UIActivityIndicatorView = {
    let a = UIActivityIndicatorView(style: .large)
    a.hidesWhenStopped = true
    a.translatesAutoresizingMaskIntoConstraints = false
    return a
  }()

  private lazy var messageLabel: UILabel = {
    let l = UILabel()
    l.text = "Carregando..."
    l.font = .systemFont(ofSize: 16, weight: .medium)
    l.textAlignment = .center
    l.textColor = .label
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()

  private override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  static func start(in view: UIView? = nil) {
    DispatchQueue.main.async {
      let target = view ?? UIApplication.mc_primaryKeyWindow
      guard let container = target else { return }
      Loading.shared.show(in: container)
    }
  }

  static func stop() {
    DispatchQueue.main.async {
      Loading.shared.hide()
    }
  }

  private func setupView() {
    isUserInteractionEnabled = true
    backgroundColor = .clear
    alpha = 0.0

    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(blurView)
    addSubview(containerView)
    containerView.addSubview(activityIndicator)
    containerView.addSubview(messageLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([

      blurView.topAnchor.constraint(equalTo: topAnchor),
      blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
      blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blurView.bottomAnchor.constraint(equalTo: bottomAnchor),

      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
      containerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -32),

      activityIndicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

      messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 12),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
    ])
  }

  private func show(in view: UIView) {
    if superview != nil { return }

    translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(self)

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: view.topAnchor),
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    activityIndicator.startAnimating()

    UIView.animate(withDuration: 0.25) {
      self.alpha = 1.0
    }
  }

  private func hide() {
    guard superview != nil else { return }
    UIView.animate(withDuration: 0.25, animations: {
      self.alpha = 0.0
    }, completion: { _ in
      self.activityIndicator.stopAnimating()
      self.removeFromSuperview()
    })
  }
}
