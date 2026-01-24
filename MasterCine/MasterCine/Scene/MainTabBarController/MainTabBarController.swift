//
//  MainTabBarController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabs()
    setupAppearance()
  }

  private func setupTabs() {
    let homeVC = HomeViewController()
    let favoritesVC = FavoritesViewController()
    let profileVC = ProfileViewController()

    let homeNav = UINavigationController(rootViewController: homeVC)
    let favoritesNav = UINavigationController(rootViewController: favoritesVC)
    let profileNav = UINavigationController(rootViewController: profileVC)

    homeNav.tabBarItem = UITabBarItem(title: "Home",
                                      image: UIImage(systemName: "house"), tag: 0)

    favoritesNav.tabBarItem = UITabBarItem(title: "Favoritos",
                                           image: UIImage(systemName: "heart"), tag: 1)

    profileNav.tabBarItem = UITabBarItem(title: "Perfil",
                                         image: UIImage(systemName: "person"), tag: 2)

    viewControllers = [homeNav, favoritesNav, profileNav]
  }

  private func setupAppearance() {
    tabBar.isTranslucent = false
  }
}
