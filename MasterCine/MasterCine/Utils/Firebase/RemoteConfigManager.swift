//
//  RemoteConfigManager.swift
//  MasterCine
//
//  Created by Caio Fabrini on 27/04/26.
//


import Foundation
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case showNewHome = "show_movie_detail" // Exibir tela de detalhes do filme
}

final class RemoteConfigManager {

  static let shared = RemoteConfigManager()

  private let remoteConfig: RemoteConfig

  private init() {
    self.remoteConfig = RemoteConfig.remoteConfig()
    setupRemoteConfig()
  }

  private func setupRemoteConfig() {
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0 // 3600

    remoteConfig.configSettings = settings
  }

  func fetchRemoteConfig(completion: ((Bool) -> Void)? = nil) {
    remoteConfig.fetchAndActivate { [weak self] status, error in
      guard let self else { return }
      if let error {
        print("Remote Config error: \(error.localizedDescription)")
        completion?(false)
        return
      }

      switch status {
      case .successFetchedFromRemote:
        print("Remote Config fetched from remote")

      case .successUsingPreFetchedData:
        print("Remote Config using pre-fetched data")

      case .error:
        print("Remote Config fetch error")
        completion?(false)
        return

      @unknown default:
        print("Remote Config unknown status")
      }
      printAllRemoteConfigValues()
      completion?(true)
    }
  }

  func getBool(forKey key: RemoteConfigKey) -> Bool {
    remoteConfig[key.rawValue].boolValue
  }

  func getString(forKey key: RemoteConfigKey) -> String {
    remoteConfig[key.rawValue].stringValue
  }

  func getInt(forKey key: RemoteConfigKey) -> Int {
    remoteConfig[key.rawValue].numberValue.intValue
  }

  func getDouble(forKey key: RemoteConfigKey) -> Double {
    remoteConfig[key.rawValue].numberValue.doubleValue
  }

  func getObject<T: Decodable>(
    forKey key: RemoteConfigKey,
    type: T.Type
  ) -> T? {
    let jsonString = remoteConfig[key.rawValue].stringValue

    guard let data = jsonString.data(using: .utf8) else {
      return nil
    }

    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("Remote Config JSON decode error: \(error.localizedDescription)")
      return nil
    }
  }

  func printAllRemoteConfigValues() {
      let keys = remoteConfig.allKeys(from: .remote)

      print("========== REMOTE CONFIG VALUES ==========")

      if keys.isEmpty {
          print("Nenhuma chave remota encontrada.")
      }

      keys.forEach { key in
          let value = remoteConfig[key]

          print("""
          Key: \(key)
          String: \(value.stringValue)
          Bool: \(value.boolValue)
          Number: \(value.numberValue)
          Source: \(value.source.rawValue)
          -----------------------------------
          """)
      }

      print("==========================================")
  }
}
