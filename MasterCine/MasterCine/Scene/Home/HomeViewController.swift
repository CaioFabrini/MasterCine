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
    viewModel.viewDidLoad()
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
    viewModel.numberOfItems
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: MovieCell.identifier,
      for: indexPath
    ) as? MovieCell else {
      return UITableViewCell()
    }

    cell.setupCell(with: viewModel.movie(at: indexPath.row))
    return cell
  }
}

extension HomeViewController: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.search(text: searchText)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
    viewModel.search(text: "")
  }
}
