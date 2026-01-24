import Foundation

protocol RegisterViewModelProtocol: AnyObject {
  func startLoading()
  func stopLoading()
  func registerDidSucceed()
  func registerDidFail(message: String)
  func backToLoginTapped()
}

final class RegisterViewModel {

  weak var delegate: RegisterViewModelProtocol?

  func register(email: String, password: String, confirmPassword: String) {
    guard Validator.isValidEmail(email) else {
      delegate?.registerDidFail(message: "Digite um e-mail válido.")
      return
    }

    guard Validator.isValidPassword(password) else {
      delegate?.registerDidFail(message: "A senha deve ter pelo menos 6 caracteres.")
      return
    }

    guard password == confirmPassword else {
      delegate?.registerDidFail(message: "As senhas não conferem.")
      return
    }

    delegate?.startLoading()

    FirebaseAuthManager.createUser(email: email, password: password) { [weak self] result in
      guard let self else { return }
      self.delegate?.stopLoading()

      switch result {
      case .success:
        self.delegate?.registerDidSucceed()
      case .failure(let error):
        self.delegate?.registerDidFail(message: error.message)
      }
    }
  }

  func backToLogin() {
    delegate?.backToLoginTapped()
  }
}
