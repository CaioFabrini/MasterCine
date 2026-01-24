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
    openRegister()
  }

  private func openRegister() {
    let registerVC = RegisterViewController()
    navigationController?.pushViewController(registerVC, animated: true)
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
    let tab = MainTabBarController()
    tab.modalPresentationStyle = .fullScreen
    present(tab, animated: true)
  }

  func loginDidFail(message: String) {
    showError(message: message)
  }
}
