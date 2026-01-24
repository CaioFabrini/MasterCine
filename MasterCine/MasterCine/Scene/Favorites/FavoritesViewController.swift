//
//  FavoritesViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class FavoritesViewController: BaseViewController {

  private let screen = FavoritesScreen()

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Favoritos"
  }
}
