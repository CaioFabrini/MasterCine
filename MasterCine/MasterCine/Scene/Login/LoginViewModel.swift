//
//  LoginViewModel.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
  func startLoading()
  func stopLoading()
  func loginDidSucceed()
  func loginDidFail(message: String)
}

final class LoginViewModel {

  public weak var delegate: LoginViewModelProtocol?

  private let authManager: FirebaseAuthManager

  public init(authManager: FirebaseAuthManager = FirebaseAuthManager()) {
    self.authManager = authManager
  }

  public func login(email: String, password: String) {
    guard isValidEmail(email) else {
      delegate?.loginDidFail(message: "Digite um e-mail válido.")
      return
    }

    guard password.count >= 6 else {
      delegate?.loginDidFail(message: "Senha inválida.")
      return
    }

    delegate?.startLoading()

    authManager.signIn(email: email, password: password) { [weak self] result in
      guard let self else { return }
      self.delegate?.stopLoading()

      switch result {
      case .success:
        self.delegate?.loginDidSucceed()

      case .failure(let error):
        self.delegate?.loginDidFail(message: error.message)
      }
    }
  }

  private func isValidEmail(_ email: String) -> Bool {
    email.contains("@") && email.contains(".")
  }
}
