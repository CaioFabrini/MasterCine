//
//  HomeViewModel.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/01/26.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
  func didUpdateMovies()
  func didChangeLoading(start: Bool)
}

final class HomeViewModel {

  weak var delegate: HomeViewModelProtocol?

  private var service = HomeService()
  private var movies: [Movie] = []

  private(set) var isError: Bool = false
  private var isInitialRequest: Bool = true

  private var currentPage: Int = 1
  private var totalPages: Int = 1
  private var isLoadingPage: Bool = false
  private var currentQuery: String = ""

  private var hasMorePages: Bool {
    return currentPage < totalPages
  }

  func fetchPopularMovies() {
    currentQuery = ""
    currentPage = 1
    totalPages = 1
    isError = false

    fetchPopularMovies(page: currentPage, isPagination: false)
  }

  private func fetchPopularMovies(page: Int, isPagination: Bool) {
    guard !isLoadingPage else { return }

    isLoadingPage = true

    if !isPagination {
      delegate?.didChangeLoading(start: true)
    }

    service.fetchPopular(page: page) { [weak self] result in
      guard let self else { return }

      self.isLoadingPage = false

      if !isPagination {
        self.delegate?.didChangeLoading(start: false)
      }

      switch result {
      case .success(let success):
        self.currentPage = success.page
        self.totalPages = success.totalPages
        self.isError = false

        if isPagination {
          self.movies.append(contentsOf: success.results)
        } else {
          self.movies = success.results
        }

      case .failure:
        self.isError = true

        if !isPagination {
          self.movies.removeAll()
        }
      }

      self.isInitialRequest = false
      self.delegate?.didUpdateMovies()
    }
  }

  private func fetchSearch(query: String) {
    currentQuery = query
    currentPage = 1
    totalPages = 1
    isError = false

    fetchSearch(query: query, page: currentPage, isPagination: false)
  }

  private func fetchSearch(query: String, page: Int, isPagination: Bool) {
    guard !isLoadingPage else { return }

    isLoadingPage = true

    if !isPagination {
      delegate?.didChangeLoading(start: true)
    }

    service.search(query: query, page: page) { [weak self] result in
      guard let self else { return }

      self.isLoadingPage = false

      if !isPagination {
        self.delegate?.didChangeLoading(start: false)
      }

      switch result {
      case .success(let success):
        self.currentPage = success.page
        self.totalPages = success.totalPages
        self.isError = false

        if isPagination {
          self.movies.append(contentsOf: success.results)
        } else {
          self.movies = success.results
        }

      case .failure:
        self.isError = true

        if !isPagination {
          self.movies.removeAll()
        }
      }

      self.isInitialRequest = false
      self.delegate?.didUpdateMovies()
    }
  }

  func loadNextPageIfNeeded(index: Int) {
    guard !isError else { return }
    guard !isEmptyMovie else { return }
    guard hasMorePages else { return }
    guard !isLoadingPage else { return }

    let lastIndex = movies.count - 1
    let shouldLoadNextPage = index >= lastIndex - 3

    guard shouldLoadNextPage else { return }

    let nextPage = currentPage + 1

    if currentQuery.isEmpty {
      fetchPopularMovies(page: nextPage, isPagination: true)
    } else {
      fetchSearch(query: currentQuery, page: nextPage, isPagination: true)
    }
  }

  var numberOfRowsInSection: Int {
    guard !isInitialRequest else { return 0 }
    return (isError || isEmptyMovie) ? 1 : movies.count
  }

  var isEmptyMovie: Bool {
    return movies.isEmpty
  }

  func loadCurrentMovie(index: Int) -> Movie {
    return movies[index]
  }

  func search(text: String) {
    let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

    if query.isEmpty {
      fetchPopularMovies()
      return
    }

    fetchSearch(query: query)
  }
}
