//
//  MovieCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {

  static let identifier: String = String(describing: MovieTableViewCell.self)

  private lazy var posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 8
    iv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
    return iv
  }()

  private lazy var titleLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 16, weight: .semibold)
    lb.numberOfLines = 2
    return lb
  }()

  private lazy var subtitleLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 13, weight: .regular)
    lb.textColor = .darkGray
    lb.numberOfLines = 2
    return lb
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    addElements()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    contentView.addSubview(posterImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)
  }

  func setupCell(with movie: Movie) {
    titleLabel.text = movie.title
    subtitleLabel.text = buildSubtitle(movie)
    ImageLoader.shared.load(url: movie.urlImage, into: posterImageView, errorImage: UIImage(systemName: "person.slash"), showsLoading: true)
  }

  private func buildSubtitle(_ movie: Movie) -> String {
    var parts: [String] = []

    if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
      parts.append(releaseDate)
    }

    if let vote = movie.voteAverage {
      parts.append("⭐️ \(String(format: "%.1f", vote))")
    }

    return parts.joined(separator: " • ")
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      posterImageView.widthAnchor.constraint(equalToConstant: 84),
      posterImageView.heightAnchor.constraint(equalToConstant: 100),
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

      titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
    ])
  }
}
