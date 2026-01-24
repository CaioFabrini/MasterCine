//
//  LoginViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class LoginViewController: BaseViewController {
  private let viewModel: LoginViewModel = LoginViewModel()
  private let screen = LoginScreen()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configProtocols()
    setupActions()
  }

  private func configProtocols() {
    viewModel.delegate = self
  }

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
    print("go to register")
  }
}

extension LoginViewController: LoginViewModelProtocol {
  func startLoading() {
    Loading.start()
  }
  
  func stopLoading() {
    Loading.stop()
  }
  
  func loginDidSucceed() {
    showAlert(message: "Deu boom viu")
  }
  
  func loginDidFail(message: String) {
    showError(message: message)
  }
}
