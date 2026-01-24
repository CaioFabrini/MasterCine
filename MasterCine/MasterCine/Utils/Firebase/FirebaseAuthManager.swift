//
//  FirebaseAuthManager.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import Foundation
import FirebaseAuth

public struct AuthFailure: LocalizedError {
  public let message: String
  public var errorDescription: String? { message }
  public init(_ message: String) { self.message = message }
}

final class FirebaseAuthManager {

  typealias Completion = (Result<Void, AuthFailure>) -> Void

  static func signIn(email: String, password: String, completion: @escaping Completion) {
    Auth.auth().signIn(withEmail: email, password: password) { _, error in
      if let error {
        completion(.failure(self.mapFirebaseError(error)))
        return
      }
      completion(.success(()))
    }
  }

  static func createUser(email: String, password: String, completion: @escaping Completion) {
    Auth.auth().createUser(withEmail: email, password: password) { _, error in
      if let error {
        completion(.failure(self.mapFirebaseError(error)))
        return
      }
      completion(.success(()))
    }
  }

  static func signOut() -> Result<Void, AuthFailure> {
    do {
      try Auth.auth().signOut()
      return .success(())
    } catch {
      return .failure(AuthFailure("Não foi possível sair. Tente novamente."))
    }
  }

  static private func mapFirebaseError(_ error: Error) -> AuthFailure {
    let nsError = error as NSError

    guard nsError.domain == AuthErrorDomain,
          let code = AuthErrorCode(rawValue: nsError.code) else {
      return AuthFailure("Não foi possível concluir a operação. Tente novamente.")
    }

    switch code {
    case .invalidEmail:
      return AuthFailure("Digite um e-mail válido.")
    case .wrongPassword, .userNotFound, .invalidCredential:
      return AuthFailure("E-mail ou senha incorretos.")
    case .emailAlreadyInUse:
      return AuthFailure("Esse e-mail já está em uso.")
    case .weakPassword:
      return AuthFailure("Sua senha é fraca. Use uma senha mais forte.")
    case .networkError:
      return AuthFailure("Sem conexão. Tente novamente.")
    case .tooManyRequests:
      return AuthFailure("Muitas tentativas. Aguarde um pouco e tente novamente.")
    case .userDisabled:
      return AuthFailure("Sua conta foi desativada.")
    case .operationNotAllowed:
      return AuthFailure("Operação não permitida no momento.")
    default:
      return AuthFailure("Não foi possível concluir a operação. Tente novamente.")
    }
  }
}
