//
//  CastCollectionViewCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: CastCollectionViewCell.self)

  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.layer.cornerRadius = 32
    view.backgroundColor = .secondarySystemBackground
    return view
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13, weight: .semibold)
    label.numberOfLines = 2
    label.textAlignment = .center
    return label
  }()

  private lazy var characterLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .secondaryLabel
    label.numberOfLines = 2
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
    contentView.addSubview(imageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(characterLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 64),
      imageView.heightAnchor.constraint(equalToConstant: 64),

      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
      characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      characterLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
    ])
  }

  func configure(with cast: CastMember) {
    nameLabel.text = cast.name
    characterLabel.text = cast.character

    ImageLoader.shared.load(
      url: cast.profileURL,
      into: imageView,
      errorImage: UIImage(systemName: "person.crop.circle.fill"),
      showsLoading: true
    )
  }
}
