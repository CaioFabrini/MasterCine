//
//  ActionsViewData.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

protocol ActionsTableViewCellProtocol: AnyObject {
  func didTapTrailer(url: URL)
  func toggleFavorite(isFavorite: Bool)
}

final class ActionsTableViewCell: UITableViewCell {

  static let identifier = String(describing: ActionsTableViewCell.self)

  private weak var delegate: ActionsTableViewCellProtocol?
  private var trailerURL: URL?
  private var isFavorite: Bool = false

  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .secondarySystemBackground
    view.layer.cornerRadius = 18
    view.clipsToBounds = true
    return view
  }()

  private lazy var trailerButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "Trailer"
    config.image = UIImage(systemName: "play.fill")
    config.imagePadding = 10
    config.baseForegroundColor = .label
    config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)

    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapTrailer), for: .touchUpInside)
    return button
  }()

  private lazy var favoriteButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "Favoritar"
    config.image = UIImage(systemName: "heart")
    config.imagePadding = 10
    config.baseForegroundColor = .label
    config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)

    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    
    return button
  }()

  private lazy var dividerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.separator.withAlphaComponent(0.35)
    return view
  }()

  private lazy var buttonsStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [trailerButton, dividerView, favoriteButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.alignment = .fill
    stack.distribution = .fill
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
    delegate = nil
    trailerURL = nil
    isFavorite = false
    containerView.isHidden = false
    updateFavoriteUI()
  }

  func setupCell(viewData: ActionsViewData, delegate: ActionsTableViewCellProtocol) {
    self.delegate = delegate
    trailerURL = viewData.trailerURL
    isFavorite = viewData.isFavorite
    trailerButton.isHidden = viewData.trailerURL == nil
    dividerView.isHidden = viewData.trailerURL == nil
    updateFavoriteUI()
  }

  private func updateFavoriteUI() {

    let imageName = isFavorite ? "heart.fill" : "heart"
    let title = isFavorite ? "Favoritado" : "Favoritar"
    let color: UIColor = isFavorite ? .systemPink : .label

    let changes = {
      self.favoriteButton.configuration?.title = title
      self.favoriteButton.configuration?.image = UIImage(systemName: imageName)
      self.favoriteButton.configuration?.baseForegroundColor = color
      self.favoriteButton.layoutIfNeeded()
    }

      UIView.transition(
        with: favoriteButton,
        duration: 0.2,
        options: [.transitionCrossDissolve, .allowUserInteraction],
        animations: changes
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
    contentView.addSubview(containerView)
    containerView.addSubview(buttonsStackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

      buttonsStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
      buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

      dividerView.widthAnchor.constraint(equalToConstant: 1)
    ])
  }

  @objc private func didTapTrailer() {
    guard let trailerURL else { return }
    delegate?.didTapTrailer(url: trailerURL)
  }

  @objc private func didTapFavorite() {
    isFavorite.toggle()
    updateFavoriteUI()
    delegate?.toggleFavorite(isFavorite: isFavorite)
  }
}
