import UIKit

final class RegisterScreen: UIView {
  
  lazy var logoImageView: UIImageView = {
    let iv = UIImageView(image: UIImage(systemName: "film"))
    iv.contentMode = .scaleAspectFit
    iv.tintColor = .label
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  lazy var titleLabel: UILabel = {
    let l = UILabel()
    l.text = "Criar conta"
    l.font = .systemFont(ofSize: 28, weight: .bold)
    l.textAlignment = .center
    l.textColor = .label
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()
  
  lazy var emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "E-mail"
    tf.keyboardType = .emailAddress
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.borderStyle = .roundedRect
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Senha"
    tf.isSecureTextEntry = true
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.borderStyle = .roundedRect
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var confirmPasswordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Confirmar senha"
    tf.isSecureTextEntry = true
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.borderStyle = .roundedRect
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  lazy var createAccountButton: UIButton = {
    let b = UIButton(type: .system)
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = .systemBlue
    config.baseForegroundColor = .white
    config.cornerStyle = .medium
    config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
    config.attributedTitle = AttributedString("Criar conta", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]))
    b.configuration = config
    b.translatesAutoresizingMaskIntoConstraints = false
    return b
  }()
  
  lazy var backToLoginButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Já tenho conta", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
    b.translatesAutoresizingMaskIntoConstraints = false
    return b
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = .systemBackground
    addSubviews()
    setupConstraints()
  }
  
  func addSubviews() {
    addSubview(logoImageView)
    addSubview(titleLabel)
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(confirmPasswordTextField)
    addSubview(createAccountButton)
    addSubview(backToLoginButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
      logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 64),
      logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      
      emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
      emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      emailTextField.heightAnchor.constraint(equalToConstant: 48),
      
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
      passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      passwordTextField.heightAnchor.constraint(equalToConstant: 48),
      
      confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
      confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48),
      
      createAccountButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
      createAccountButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      createAccountButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      
      backToLoginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 12),
      backToLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
}

