//
//  LoginViewModel.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import Foundation
import FirebaseAuth

// MARK: - LoginViewModelDelegate
public protocol LoginViewModelProtocol: AnyObject {
  func startLoading()
  func stopLoading()
  func loginDidSucceed()
  func loginDidFail(message: String)
}

// MARK: - LoginViewModel
public final class LoginViewModel {

  public weak var delegate: LoginViewModelProtocol?

  public init() {}

  public func login(email: String, password: String) {
    // Basic validation
    guard isValidEmail(email) else {
      delegate?.loginDidFail(message: "Digite um e-mail válido.")
      return
    }

    guard password.count >= 6 else {
      delegate?.loginDidFail(message: "Senha inválida.")
      return
    }

    delegate?.startLoading()

    Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
      guard let self else { return }
      self.delegate?.stopLoading()

      if let error {
        self.delegate?.loginDidFail(message: self.mapFirebaseError(error))
        return
      }

      self.delegate?.loginDidSucceed()
    }
  }

  // MARK: - Helpers
  private func isValidEmail(_ email: String) -> Bool {
    email.contains("@") && email.contains(".")
  }

  private func mapFirebaseError(_ error: Error) -> String {
    let nsError = error as NSError

    guard nsError.domain == AuthErrorDomain,
          let code = AuthErrorCode(rawValue: nsError.code) else {
      return "Não foi possível entrar. Tente novamente."
    }

    switch code {
    case .invalidEmail:
      return "Digite um e-mail válido."
    case .wrongPassword, .userNotFound:
      return "E-mail ou senha incorretos."
    case .networkError:
      return "Sem conexão. Tente novamente."
    case .tooManyRequests:
      return "Muitas tentativas. Aguarde um pouco e tente novamente."
    case .invalidCredential:
      return "E-mail ou senha incorretos."
    default:
      return "Não foi possível entrar. Tente novamente."
    }
  }
}
