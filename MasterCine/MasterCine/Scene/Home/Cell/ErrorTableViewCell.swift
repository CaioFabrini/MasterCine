//
//  ErrorTableViewCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//


import UIKit

final class ErrorTableViewCell: UITableViewCell {

  static let identifier = String(describing: ErrorTableViewCell.self)

  private lazy var errorImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    view.tintColor = .secondaryLabel
    view.image = UIImage(systemName: "exclamationmark.triangle")
    return view
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      errorImageView,
      descriptionLabel
    ])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 16
    return stack
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    errorImageView.image = nil
    descriptionLabel.text = nil
  }

  func setupCell(message: String) {
    descriptionLabel.text = message
  }

  private func setupView() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    addElements()
    setupConstraints()
  }

  private func addElements() {
    contentView.addSubview(stackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),

      errorImageView.widthAnchor.constraint(equalToConstant: 120),
      errorImageView.heightAnchor.constraint(equalToConstant: 120)
    ])
  }
}
