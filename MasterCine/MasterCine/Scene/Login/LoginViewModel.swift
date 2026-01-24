//
//  LoginViewModelProtocol.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import Foundation

// MARK: - LoginViewModelProtocol
protocol LoginViewModelProtocol: AnyObject {
  func login(email: String, password: String)
  func createAccountTapped()
}

// MARK: - LoginViewModel
final class LoginViewModel: LoginViewModelProtocol {
  func login(email: String, password: String) {
    // TODO: Implement real login logic (network/validation) later
    print("Login tapped with email: \(email)")
  }

  func createAccountTapped() {
    // TODO: Route to sign up screen later
    print("Create account tapped")
  }
}
