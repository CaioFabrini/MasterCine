import UIKit

final class RegisterViewController: BaseViewController {
  private let viewModel = RegisterViewModel()
  private let screen = RegisterScreen()

  override func loadView() {
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setupActions()
    title = "Cadastro"
  }

  private func setupActions() {
    screen.createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    screen.backToLoginButton.addTarget(self, action: #selector(didTapBackToLogin), for: .touchUpInside)
  }

  @objc private func didTapCreateAccount() {
    let email = screen.emailTextField.text ?? ""
    let password = screen.passwordTextField.text ?? ""
    let confirm = screen.confirmPasswordTextField.text ?? ""
    viewModel.register(email: email, password: password, confirmPassword: confirm)
  }

  @objc private func didTapBackToLogin() {
    viewModel.backToLogin()
  }
}

extension RegisterViewController: RegisterViewModelProtocol {
  func startLoading() {
    Loading.start()
  }

  func stopLoading() {
    Loading.stop()
  }

  func registerDidSucceed() {
    print("BOOM - cadastro ok")
  }

  func registerDidFail(message: String) {
    showError(message: message)
  }

  func backToLoginTapped() {
    navigationController?.popViewController(animated: true)
  }
}
