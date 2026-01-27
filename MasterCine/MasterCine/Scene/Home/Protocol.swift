//
//  HomeViewModelDelegate.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
  func didUpdate()
  func didFail(message: String)
  func didChangeLoading(isLoading: Bool)
}

final class HomeViewModel {

  weak var delegate: HomeViewModelProtocol?

  private let service: TMDbServiceProtocol = TMDbService()
  private var movies: [Movie] = []
  private var pendingSearchWorkItem: DispatchWorkItem?
  private var currentQuery = ""

  var numberOfItems: Int {
    movies.count
  }

  func viewDidLoad() {
    fetchPopular()
  }

  func search(text: String) {
    currentQuery = text.trimmingCharacters(in: .whitespacesAndNewlines)

    pendingSearchWorkItem?.cancel()

    let workItem = DispatchWorkItem { [weak self] in
      guard let self else { return }

      if self.currentQuery.isEmpty {
        self.fetchPopular()
      } else {
        self.searchMovies(query: self.currentQuery)
      }
    }

    pendingSearchWorkItem = workItem
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: workItem)
  }

  func movie(at index: Int) -> Movie {
    movies[index]
  }

  private func fetchPopular() {
    setLoading(true)

    service.fetchPopular(page: 1) { [weak self] result in
      guard let self else { return }
      self.setLoading(false)

      switch result {
      case .success(let response):
        self.movies = response.results
        self.delegate?.didUpdate()

      case .failure(let error):
        self.delegate?.didFail(message: error.userMessage)
      }
    }
  }

  private func searchMovies(query: String) {
    setLoading(true)

    service.search(query: query, page: 1) { [weak self] result in
      guard let self else { return }
      self.setLoading(false)

      switch result {
      case .success(let response):
        self.movies = response.results
        self.delegate?.didUpdate()

      case .failure(let error):
        self.delegate?.didFail(message: error.userMessage)
      }
    }
  }

  private func setLoading(_ isLoading: Bool) {
    DispatchQueue.main.async { [weak self] in
      self?.delegate?.didChangeLoading(isLoading: isLoading)
    }
  }
}
