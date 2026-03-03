//
//  EditableProfileCell.swift
//  MasterCine
//
//  Created by Marcello Pontes Domingos on 26/02/26.
//

import UIKit

final class EditableProfileCell: UITableViewCell {
    
    static let identifier = "EditableProfileCell"
    
    private let titleLabel = UILabel()
    let textField: UITextField
    var onTextChange: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.textField = UITextField()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        selectionStyle = .none
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 44),
            contentView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        ])
        
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        onTextChange?(textField.text ?? "")
    }
    
    func configure(field: ProfileFieldModel, isEditing: Bool) {
        titleLabel.text = field.title
        textField.placeholder = field.placeholder
        textField.text = field.value
        textField.isUserInteractionEnabled = isEditing
    }
}
