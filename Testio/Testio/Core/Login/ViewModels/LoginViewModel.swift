//
//  LoginViewModel.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
    }

    private let userService: UserServiceProtocol

    @Published var showAlert: Bool = false
    @Published private(set) var loginState = State.idle

    let loginContainerViewModel: LoginContainerViewModel = LoginContainerViewModel()
    let errorMessageTitle: String = BasicStrings.loginFailedTitle
    let errorMessageSubtitle: String = BasicStrings.loginFailedSubtitle
    let loadingText: String = BasicStrings.loading
    let backgroundImage: Image? = BasicImages.background.image
    let logoImage: Image? = BasicImages.logo.image

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService

        loginContainerViewModel.action = { [weak self] in
            self?.loginUser()
        }
    }

    private func loginUser() {
        loginState = .loading
        let user = User(username: loginContainerViewModel.username,
                        password: loginContainerViewModel.password)
        Task {
            do {
                let data = try await userService.getToken(user: user)
                await MainActor.run {
                    AppManager.setToken(data.token)
                    loginState = .idle
                }
            } catch {
                await MainActor.run {
                    showAlert.toggle()
                    loginState = .idle
                }
            }
        }
    }
}
