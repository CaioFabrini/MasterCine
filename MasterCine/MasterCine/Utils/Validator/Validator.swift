//
//  Validator.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//


import Foundation

/// Estrutura responsável por centralizar validações simples do aplicativo.
struct Validator {

  /// Verifica se o e-mail contém os caracteres básicos "@" e ".".
  static func isValidEmail(_ email: String) -> Bool {
    let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.contains("@") && trimmed.contains(".")
  }

  /// Verifica se a senha possui pelo menos 6 caracteres.
  static func isValidPassword(_ password: String) -> Bool {
    password.count >= 6
  }
}
