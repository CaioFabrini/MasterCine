//
//  HeaderTableViewCell.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class HeaderTableViewCell: UITableViewCell {

  static let identifier = String(describing: HeaderTableViewCell.self)

  lazy var headerView: MovieDetailHeaderView = {
    let view = MovieDetailHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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
    headerView.posterImageView.image = nil
    headerView.backdropImageView.image = nil
    headerView.titleLabel.text = nil
    headerView.subtitleLabel.text = nil
  }

  func setupCell(headerData: HeaderViewData) {
    headerView.titleLabel.text = headerData.title
    headerView.subtitleLabel.text = headerData.subtitle

    ImageLoader.shared.load(
      url: headerData.posterURL,
      into: headerView.posterImageView,
      showsLoading: false
    )

    ImageLoader.shared.load(
      url: headerData.backdropURL,
      into: headerView.backdropImageView,
      showsLoading: true
    )
  }

  private func setupView() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    addElements()
    setupConstraints()
  }

  private func addElements() {
    contentView.addSubview(headerView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
