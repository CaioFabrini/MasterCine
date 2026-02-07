//
//  OverviewViewData.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class OverviewTableViewCell: UITableViewCell {

  static let identifier = String(describing: OverviewTableViewCell.self)

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Sinopse"
    label.font = .systemFont(ofSize: 18, weight: .bold)
    label.textColor = .label
    return label
  }()

  private lazy var overviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    return label
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 10
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
    overviewLabel.text = nil
  }

  func setupCell(viewData: OverviewViewData) {
    overviewLabel.text = viewData.text
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
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}
