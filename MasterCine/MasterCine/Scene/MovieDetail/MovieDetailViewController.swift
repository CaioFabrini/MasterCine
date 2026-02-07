//
//  MovieDetailViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 28/01/26.
//

import UIKit

final class MovieDetailViewController: UIViewController {

  private let screen = MovieDetailScreen()
  private let viewModel: MovieDetailViewModel

  init(viewModel: MovieDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Detalhe do Filme"
    configProtocols()
    viewModel.fetch()
  }

  func configProtocols() {
    screen.configTableViewProtocols(delegate: self, dataSource: self)
    viewModel.delegate = self
  }
}

extension MovieDetailViewController: MovieDetailViewModelProtocol {
  func didUpdate() {
    screen.tableView.reloadData()
  }
  
  func didChangeLoading(isLoading: Bool) {
    _ = isLoading ? Loading.start() : Loading.stop()
  }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch viewModel.row(at: indexPath) {

    case .header(let headerData):
      let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as? HeaderTableViewCell
      cell?.setupCell(headerData: headerData)
      return cell ?? UITableViewCell()

    case .actions(let actionsData):
      let cell = tableView.dequeueReusableCell(withIdentifier: ActionsTableViewCell.identifier) as? ActionsTableViewCell
      cell?.setupCell(viewData: actionsData, delegate: self)
      return cell ?? UITableViewCell()

    case .overview(let overviewData):
      let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell
      cell?.setupCell(viewData: overviewData)
      return cell ?? UITableViewCell()

    case .genres(let genresData):
      let cell = tableView.dequeueReusableCell(withIdentifier: GenresTableViewCell.identifier) as? GenresTableViewCell
      cell?.setupCell(viewData: genresData)
      return cell ?? UITableViewCell()

    case .cast(let castData):
      let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell
      cell?.setupCell(viewData: castData)
      return cell ?? UITableViewCell()

    case .recommendations(let recommendationData):
      let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationsTableViewCell.identifier) as? RecommendationsTableViewCell
      cell?.setupCell(viewData: recommendationData, delegate: self)
      return cell ?? UITableViewCell()

    case .error(let message):
      let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier) as? ErrorTableViewCell
      cell?.setupCell(message: message)
      return cell ?? UITableViewCell()
    }
  }
}

extension MovieDetailViewController: ActionsTableViewCellProtocol {
  func didTapTrailer(url: URL) {
    UIApplication.shared.open(url)
  }
  
  func toggleFavorite(isFavorite: Bool) {
    print(#function)
  }
}

extension MovieDetailViewController: RecommendationsTableViewCellProtocol {
  func didTapRecommendation(_ movie: MovieSummary) {
    let vc = MovieDetailViewController(viewModel: MovieDetailViewModel(movieId: movie.id))
    navigationController?.pushViewController(vc, animated: true)
  }
}
