//
//  HomeViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class HomeViewController: BaseViewController {

  private let screen = HomeScreen()
  private let viewModel = HomeViewModel()

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    setup()
    viewModel.fetchPopularIfNeeded()
  }

  private func setup() {
    viewModel.delegate = self
    screen.tableView.dataSource = self
    screen.tableView.delegate = self
    screen.searchBar.delegate = self
  }
}

extension HomeViewController: HomeViewModelProtocol {

  func didUpdate() {
    screen.tableView.reloadData()
  }

  func didFail(message: String) {
    let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }

  func didChangeLoading(isLoading: Bool) {
    _ = isLoading ? Loading.start() : Loading.stop()
  }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.isEmpty ? 1 : viewModel.numberOfItems
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if viewModel.isEmpty {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: EmptyStateTableViewCell.identifier,
        for: indexPath
      ) as? EmptyStateTableViewCell else {
        return UITableViewCell()
      }
      cell.setupCell(
        title: "Nenhum filme encontrado",
        subtitle: "Tente buscar por outro título."
      )
    return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: MovieTableViewCell.identifier,
        for: indexPath
      ) as? MovieTableViewCell else {
        return UITableViewCell()
      }

      cell.setupCell(with: viewModel.loudCurrentMovie(at: indexPath.row))
      return cell
    }
  }
}

extension HomeViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    viewModel.search(text: searchBar.text ?? "")
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard searchText.isEmpty else { return }
    searchBar.resignFirstResponder()
    viewModel.search(text: "")
  }
}
