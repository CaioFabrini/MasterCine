//
//  LoginViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

// MARK: - LoginViewController
final class LoginViewController: UIViewController {

  // MARK: Properties
  private let viewModel: LoginViewModelProtocol
  private let screen = LoginScreen()

  // MARK: Initializers
  init(viewModel: LoginViewModelProtocol = LoginViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Lifecycle
  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupActions()
  }

  // MARK: Private
  private func setupActions() {
    screen.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    screen.createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
  }

  @objc private func didTapLogin() {
    let email = screen.emailTextField.text ?? ""
    let password = screen.passwordTextField.text ?? ""
    viewModel.login(email: email, password: password)
  }

  @objc private func didTapCreateAccount() {
    viewModel.createAccountTapped()
  }
}
