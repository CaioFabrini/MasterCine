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
    sb.searchBarStyle = .minimal
    sb.showsCancelButton = true
    return sb
  }()

  lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.separatorStyle = .singleLine
    tv.rowHeight = 76
    tv.keyboardDismissMode = .onDrag
    tv.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
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
}
