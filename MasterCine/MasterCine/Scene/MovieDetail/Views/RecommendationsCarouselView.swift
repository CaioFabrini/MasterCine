//
//  RecommendationsCarouselView.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class RecommendationsCarouselView: UIView {
  private var movies: [MovieSummary] = []
  var onMovieTap: ((MovieSummary) -> Void)?

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 12
    layout.itemSize = CGSize(width: 110, height: 165)

    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.showsHorizontalScrollIndicator = false
    view.dataSource = self
    view.delegate = self
    view.register(RecommendationPosterCell.self, forCellWithReuseIdentifier: RecommendationPosterCell.identifier)
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
    translatesAutoresizingMaskIntoConstraints = false
    addElements()
    setupConstraints()
  }

  private func addElements() {
    addSubview(collectionView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 170)
    ])
  }

  func configure(movies: [MovieSummary]) {
    self.movies = movies
    collectionView.reloadData()
  }
}

extension RecommendationsCarouselView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationPosterCell.identifier, for: indexPath) as? RecommendationPosterCell else { return UICollectionViewCell() }

    let movie = movies[indexPath.item]
    cell.setImageURL(posterURL: movie.posterURL)

    return cell
  }
}

extension RecommendationsCarouselView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    onMovieTap?(movies[indexPath.item])
  }
}
