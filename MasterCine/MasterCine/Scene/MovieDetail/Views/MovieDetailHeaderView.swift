//
//  MovieDetailHeaderView.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class MovieDetailHeaderView: UIView {

  lazy var backdropImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.backgroundColor = .secondarySystemBackground
    return view
  }()

  private lazy var gradientView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
  }()

  lazy var posterImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.layer.cornerRadius = 12
    view.backgroundColor = .secondarySystemBackground
    return view
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.numberOfLines = 0
    label.textColor = .white
    return label
  }()

  lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.numberOfLines = 0
    label.textColor = UIColor.white.withAlphaComponent(0.85)
    return label
  }()

  private var gradientLayer: CAGradientLayer?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupGradientIfNeeded()
  }

  private func setupView() {
    backgroundColor = .systemBackground
    clipsToBounds = true
    addElements()
    setupConstraints()
  }

  private func addElements() {
    addSubview(backdropImageView)
    addSubview(gradientView)
    addSubview(posterImageView)
    addSubview(titleLabel)
    addSubview(subtitleLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backdropImageView.topAnchor.constraint(equalTo: topAnchor),
      backdropImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backdropImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backdropImageView.heightAnchor.constraint(equalToConstant: 300),
      backdropImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

      gradientView.topAnchor.constraint(equalTo: backdropImageView.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor),

      posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      posterImageView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -16),
      posterImageView.widthAnchor.constraint(equalToConstant: 120),
      posterImageView.heightAnchor.constraint(equalToConstant: 180),

      titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10),

      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
    ])
  }
  
  private func setupGradientIfNeeded() {
    let layer = gradientLayer ?? CAGradientLayer()
    layer.frame = gradientView.bounds

    layer.colors = [
      UIColor.clear.cgColor,
      UIColor.black.withAlphaComponent(0.85).cgColor
    ]

    layer.locations = [0.35, 1.0]

    if gradientLayer == nil {
      gradientView.layer.insertSublayer(layer, at: 0)
      gradientLayer = layer
    }
  }
}
