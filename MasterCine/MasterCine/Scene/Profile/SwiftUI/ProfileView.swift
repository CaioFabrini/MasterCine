//
//  ProfileView.swift
//  MasterCine
//
//  Created by Marcello Pontes Domingos on 03/03/26.
//


import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = SUProfileViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        
                        if viewModel.isEditing {
                            Text("Toque para alterar foto")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Section {
                    editableField(
                        title: "Nome",
                        text: Binding(
                            get: { viewModel.profile?.name ?? "" },
                            set: { viewModel.profile?.name = $0 }
                        )
                    )
                    
                    editableField(
                        title: "Email",
                        text: Binding(
                            get: { viewModel.profile?.email ?? "" },
                            set: { viewModel.profile?.email = $0 }
                        )
                    )
                    
                    editableField(
                        title: "Filme favorito",
                        text: Binding(
                            get: { viewModel.profile?.favoriteMovie ?? "" },
                            set: { viewModel.profile?.favoriteMovie = $0 }
                        )
                    )
                    
                    editableField(
                        title: "Gênero favorito",
                        text: Binding(
                            get: { viewModel.profile?.favoriteGenre ?? "" },
                            set: { viewModel.profile?.favoriteGenre = $0 }
                        )
                    )
                }
            }
            .navigationTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if viewModel.isEditing {
                            viewModel.saveProfile()
                        }
                        viewModel.isEditing.toggle()
                    } label: {
                        Image(systemName: viewModel.isEditing ? "checkmark" : "pencil")
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                viewModel.loadProfile()
            }
        }
    }
    
    @ViewBuilder
    private func editableField(title: String, text: Binding<String>) -> some View {
        if viewModel.isEditing {
            TextField(title, text: text)
        } else {
            HStack {
                Text(title)
                Spacer()
                Text(text.wrappedValue)
                    .foregroundColor(.secondary)
            }
        }
    }
}
