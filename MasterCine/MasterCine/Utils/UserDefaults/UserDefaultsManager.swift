//
//  UserDefaultsManager.swift
//  MasterCine
//
//  Created by Caio Fabrini on 29/04/26.
//

import Foundation

enum UserDefaultsKey {
  static let userName = "userName"
  static let isLogged = "isLogged"
  static let userId = "userId"
}

final class UserDefaultsManager {

  static let shared = UserDefaultsManager()

  private let userDefaults: UserDefaults

  private init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  func save<T>(_ value: T, forKey key: String) {
    userDefaults.set(value, forKey: key)
  }

  func getString(forKey key: String) -> String? {
    userDefaults.string(forKey: key)
  }

  func getBool(forKey key: String) -> Bool {
    userDefaults.bool(forKey: key)
  }

  func getInt(forKey key: String) -> Int {
    userDefaults.integer(forKey: key)
  }

  func getDouble(forKey key: String) -> Double {
    userDefaults.double(forKey: key)
  }

  func getObject<T>(forKey key: String) -> T? {
    userDefaults.object(forKey: key) as? T
  }

  func remove(forKey key: String) {
    userDefaults.removeObject(forKey: key)
  }

  func contains(key: String) -> Bool {
    userDefaults.object(forKey: key) != nil
  }

  func clearAll() {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
    userDefaults.removePersistentDomain(forName: bundleIdentifier)
  }
}
