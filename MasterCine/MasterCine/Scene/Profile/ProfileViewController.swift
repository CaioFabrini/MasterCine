//
//  ProfileViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class ProfileViewController: BaseViewController {

  private let screen = ProfileScreen()

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Perfil"
  }
}
