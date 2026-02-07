//
//  CastTableViewCellProtocol.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class CastTableViewCell: UITableViewCell {

  static let identifier = String(describing: CastTableViewCell.self)

  private var cast: [CastMember] = []

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Elenco"
    label.font = .systemFont(ofSize: 18, weight: .bold)
    label.textColor = .label
    return label
  }()

  private lazy var carouselView: CastCarouselView = {
    let view = CastCarouselView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, carouselView])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 12
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
    cast = []
    carouselView.configure(cast: [])
  }

  func setupCell(viewData: CastViewData) {
    self.cast = viewData.cast
    carouselView.configure(cast: viewData.cast)
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
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      carouselView.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
}
