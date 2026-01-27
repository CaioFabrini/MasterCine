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
    customizeTabBarAppearance()
  }

  private func setupTabs() {
    let homeVC = HomeViewController()
    let favoritesVC = FavoritesViewController()
    let profileVC = ProfileViewController()

    let homeNav = UINavigationController(rootViewController: homeVC)
    let favoritesNav = UINavigationController(rootViewController: favoritesVC)
    let profileNav = UINavigationController(rootViewController: profileVC)

    homeNav.tabBarItem = UITabBarItem(
      title: "Home",
      image: UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate),
      selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
    )

    favoritesNav.tabBarItem = UITabBarItem(
      title: "Favoritos",
      image: UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate),
      selectedImage: UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
    )

    profileNav.tabBarItem = UITabBarItem(
      title: "Perfil",
      image: UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate),
      selectedImage: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysTemplate)
    )

    viewControllers = [homeNav, favoritesNav, profileNav]
  }

  private func customizeTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundEffect = nil
    appearance.backgroundColor = .white
    appearance.shadowColor = .separator

    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = appearance
    tabBar.isTranslucent = false
    tabBar.itemPositioning = .fill
    tabBar.tintColor = .red
    tabBar.unselectedItemTintColor = .lightGray
  }
}
