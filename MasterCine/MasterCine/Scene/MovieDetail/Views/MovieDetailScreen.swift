//
//  MovieDetailScreen.swift
//  MasterCine
//
//  Created by Caio Fabrini on 28/01/26.
//

import UIKit

final class MovieDetailScreen: UIView {

  lazy var tableView: UITableView = {
    let view = UITableView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.separatorStyle = .none
    view.showsVerticalScrollIndicator = false
    view.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
    view.register(ActionsTableViewCell.self, forCellReuseIdentifier: ActionsTableViewCell.identifier)
    view.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
    view.register(GenresTableViewCell.self, forCellReuseIdentifier: GenresTableViewCell.identifier)
    view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
    view.register(RecommendationsTableViewCell.self, forCellReuseIdentifier: RecommendationsTableViewCell.identifier)
    view.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  private func setupView() {
    backgroundColor = .systemBackground
    addElements()
    setupConstraints()
  }

  private func addElements() {
    addSubview(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
  }
}
