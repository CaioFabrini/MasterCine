//
//  ProfileScreen.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class ProfileScreen: UIView {
    
    private var fields: [ProfileFieldModel] = []
    
    private var isEditingProfile = false
    
    private let keyboardToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "OK", style: .done, target: nil, action: nil)
        ]
        return toolbar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditableProfileCell.self, forCellReuseIdentifier: EditableProfileCell.identifier)
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        setupKeyboardToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setProfile(_ profile: ProfileModel?) {
        if let profile {
            fields = [
                .init(title: "Nome", placeholder: "Usuário", value: profile.name),
                .init(title: "Email", placeholder: "Meu email", value: profile.email),
                .init(title: "Filme favorito", placeholder: "Meu filme favorito", value: profile.favoriteMovie),
                .init(title: "Gênero favorito", placeholder: "Meu gênero favorito", value: profile.favoriteGenre)
            ]
        } else {
            fields = [
                .init(title: "Nome", placeholder: "Usuário", value: ""),
                .init(title: "Email", placeholder: "Meu email", value: ""),
                .init(title: "Filme favorito", placeholder: "Meu filme favorito", value: ""),
                .init(title: "Gênero favorito", placeholder: "Meu gênero favorito", value: "")
            ]
        }
        
        tableView.reloadData()
    }
    
    func setEditingMode(_ editing: Bool) {
        isEditingProfile = editing
        tableView.reloadData()
    }
    
    private func addSubviews() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupKeyboardToolbar() {
        keyboardToolbar.items?.last?.target = self
        keyboardToolbar.items?.last?.action = #selector(dismissKeyboard)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

// MARK: - UITableViewDataSource / Delegate

extension ProfileScreen: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fields.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EditableProfileCell.identifier,
            for: indexPath
        ) as? EditableProfileCell else { return UITableViewCell() }
        
        let index = indexPath.row
        let field = fields[index]
        
        cell.configure(field: field, isEditing: isEditingProfile)
        cell.onTextChange = { [weak self] text in
            self?.fields[index].value = text
        }
        cell.textField.inputAccessoryView = keyboardToolbar
        
        return cell
    }
}
