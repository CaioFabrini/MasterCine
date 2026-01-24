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

  public func login(email: String, password: String) {
    guard Validator.isValidEmail(email) else {
      delegate?.loginDidFail(message: "Digite um e-mail válido.")
      return
    }

    guard Validator.isValidPassword(password) else {
      delegate?.loginDidFail(message: "Senha inválida.")
      return
    }

    delegate?.startLoading()

    FirebaseAuthManager.signIn(email: email, password: password) { [weak self] result in
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
}
