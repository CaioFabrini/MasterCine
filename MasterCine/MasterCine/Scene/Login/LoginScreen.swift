//
//  LoginScreen.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

// MARK: - LoginScreen (ViewCode)
final class LoginScreen: UIView {
  // MARK: UI Components
  lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(systemName: "film")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .label
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "MasterCine"
    label.font = .systemFont(ofSize: 28, weight: .bold)
    label.textAlignment = .center
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.keyboardType = .emailAddress
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.borderStyle = .roundedRect
    tf.textContentType = .username
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()

  lazy var passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Senha"
    tf.isSecureTextEntry = true
    tf.borderStyle = .roundedRect
    tf.textContentType = .password
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()

  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Entrar", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.backgroundColor = .systemBlue
    button.tintColor = .white
    button.layer.cornerRadius = 10
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var createAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Não tem conta? Criar conta", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
    button.tintColor = .systemBlue
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, createAccountButton])
    stack.axis = .vertical
    stack.spacing = 12
    stack.alignment = .fill
    stack.distribution = .fill
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Setup
  private func setupView() {
    backgroundColor = .systemBackground
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(logoImageView)
    addSubview(titleLabel)
    addSubview(stackView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // Logo
      logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
      logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 72),
      logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

      // Title
      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

      // Stack
      stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

      emailTextField.heightAnchor.constraint(equalToConstant: 44),
      passwordTextField.heightAnchor.constraint(equalToConstant: 44),
      loginButton.heightAnchor.constraint(equalToConstant: 48)
    ])
  }
}
