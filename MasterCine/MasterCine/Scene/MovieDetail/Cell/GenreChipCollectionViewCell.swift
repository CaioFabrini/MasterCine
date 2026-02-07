//
//  GenreChipCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//


import UIKit

final class GenreChipCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: GenreChipCollectionViewCell.self)

  private lazy var genreChipLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .medium)
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addElements()
    configConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  private func addElements() {
    contentView.backgroundColor = .secondarySystemBackground
    contentView.layer.cornerRadius = 14
    contentView.addSubview(genreChipLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      genreChipLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
      genreChipLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
      genreChipLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      genreChipLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
    ])
  }

  func configure(text: String) {
    genreChipLabel.text = text
  }
}
