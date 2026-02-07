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
    configProtocols()
    viewModel.fetchPopularIfNeeded()
  }

  private func configProtocols() {
    viewModel.delegate = self
    screen.searchBar.delegate = self
    screen.configTableViewProtocols(delegate: self, dataSource: self)
  }
}

extension HomeViewController: HomeViewModelProtocol {
  func didUpdate() {
    screen.tableView.reloadData()
  }

  func didChangeLoading(isLoading: Bool) {
    _ = isLoading ? Loading.start() : Loading.stop()
  }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if viewModel.isError {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier,
                                                     for: indexPath) as? ErrorTableViewCell else { return UITableViewCell() }
      cell.setupCell(message: "Deu ruim em")
      return cell
    } else if viewModel.isEmptyMovie {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyStateTableViewCell.identifier,
                                                     for: indexPath) as? EmptyStateTableViewCell else { return UITableViewCell() }
      cell.setupCell(title: "Nenhum filme encontrado", subtitle: "Tente buscar por outro título.")
      return cell

    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                     for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
      cell.setupCell(with: viewModel.loudCurrentMovie(at: indexPath.row))
      return cell
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard !viewModel.isEmptyMovie && !viewModel.isError else { return }
    let movieId = viewModel.loudCurrentMovie(at: indexPath.row).id
    let vc = MovieDetailViewController(viewModel: MovieDetailViewModel(movieId: movieId))
    navigationController?.pushViewController(vc, animated: true)
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
