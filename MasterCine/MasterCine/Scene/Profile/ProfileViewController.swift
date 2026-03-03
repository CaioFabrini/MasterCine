//
//  ProfileViewController.swift
//  MasterCine
//
//  Created by Caio Fabrini on 24/01/26.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    private let screen = ProfileScreen()
    private let viewModel = ProfileViewModel()
    
    private var isEditingFields = false {
        didSet {
            setBarButton(editingMode: isEditingFields)
        }
    }
    
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perfil"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let profile = viewModel.getProfile()
        screen.setProfile(profile)
        setBarButton(editingMode: false)
    }
    
    private func setBarButton(editingMode: Bool) {
        let imageName = editingMode ? "checkmark" : "pencil"
        
        let barButton = UIBarButtonItem(
            image: UIImage(systemName: imageName),
            style: .plain,
            target: self,
            action: #selector(editProfile)
        )
        
        barButton.tintColor = .red
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func editProfile() {
        isEditingFields = !isEditingFields
        screen.setEditingMode(isEditingFields)
    }
}
