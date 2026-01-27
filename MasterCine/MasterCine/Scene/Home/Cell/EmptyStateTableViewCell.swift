//
//  EmptyStateCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//


import UIKit

final class EmptyStateTableViewCell: UITableViewCell {

  static let identifier: String = String(describing: EmptyStateTableViewCell.self)

  private lazy var iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    iv.tintColor = .lightGray
    iv.image = UIImage(systemName: "film")
    return iv
  }()

  private lazy var titleLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 18, weight: .semibold)
    lb.textColor = .darkGray
    lb.textAlignment = .center
    lb.numberOfLines = 0
    return lb
  }()

  private lazy var subtitleLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 14, weight: .regular)
    lb.textColor = .lightGray
    lb.textAlignment = .center
    lb.numberOfLines = 0
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

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    subtitleLabel.text = nil
  }

  func setupCell(title: String,subtitle: String) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
  }

  private func addElements() {
    contentView.addSubview(iconImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      iconImageView.heightAnchor.constraint(equalToConstant: 48),
      iconImageView.widthAnchor.constraint(equalToConstant: 48),

      titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
      subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
