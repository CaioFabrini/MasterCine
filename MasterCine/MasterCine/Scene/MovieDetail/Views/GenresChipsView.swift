//
//  GenresChipsView.swift
//  MasterCine
//
//  Created by Caio Fabrini on 07/02/26.
//

import UIKit

final class GenresChipsView: UIView {
  
  private var genres: [String] = []
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 8
    layout.sectionInset = .zero
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.showsHorizontalScrollIndicator = false
    view.dataSource = self
    view.delegate = self
    view.register(GenreChipCollectionViewCell.self,forCellWithReuseIdentifier: GenreChipCollectionViewCell.identifier)
    
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
      collectionView.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  func configure(genres: [String]) {
    self.genres = genres
    collectionView.reloadData()
  }
}

extension GenresChipsView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    genres.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreChipCollectionViewCell.identifier,
                                                        for: indexPath) as? GenreChipCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.configure(text: genres[indexPath.item])
    return cell
  }
}

extension GenresChipsView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let text = genres[indexPath.item]
    let width = text.size(withAttributes: [
      .font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]).width
    
    return CGSize(width: width + 28, height: 28)
  }
}
