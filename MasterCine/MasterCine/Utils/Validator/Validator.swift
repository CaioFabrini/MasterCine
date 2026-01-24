//
//  Validator.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//


import Foundation

struct Validator {

  static func isValidEmail(_ email: String) -> Bool {
    let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.contains("@") && trimmed.contains(".")
  }

  static func isValidPassword(_ password: String) -> Bool {
    password.count >= 6
  }
}
