//
//  HomeScreen.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class HomeScreen: UIView {

  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.translatesAutoresizingMaskIntoConstraints = false
    sb.placeholder = "Buscar filmes"
    sb.searchBarStyle = .default
    sb.showsCancelButton = false
    sb.inputAccessoryView = keyboardAccessoryView()
    return sb
  }()

  lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.separatorStyle = .singleLine
    tv.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    tv.register(EmptyStateTableViewCell.self, forCellReuseIdentifier: EmptyStateTableViewCell.identifier)
    tv.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
    return tv
  }()

  init() {
    super.init(frame: .zero)
    backgroundColor = .white
    addElements()
    configConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    addSubview(searchBar)
    addSubview(tableView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  private func keyboardAccessoryView() -> UIView {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()

    let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    let done = UIBarButtonItem(
      title: "Fechar",
      style: .done,
      target: self,
      action: #selector(dismissKeyboard)
    )

    toolbar.items = [flex, done]
    return toolbar
  }

  @objc private func dismissKeyboard() {
    endEditing(true)
  }

  func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
  }
}
