//
//  LoginFieldsView.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Constants {
    struct LoginContainer {
        static let spacing = CGFloat(20)
        static let buttonTopPadding = CGFloat(10)
    }
}

struct LoginContainerView: View {

    @ObservedObject var viewModel: LoginContainerViewModel

    var body: some View {
        VStack(spacing: Constants.LoginContainer.spacing) {

            usernameTextField

            passwordTextField

            loginButton
                .padding(.top, Constants.LoginContainer.buttonTopPadding)
        }
    }

    private var usernameTextField: some View {
        CustomTextField(text: $viewModel.username,
                        placeholderText: viewModel.usernameText,
                        type: .filled(textColor: ColorTheme.foreground.color,
                                      backgroundColor: ColorTheme.textfield.color,
                                      maxWidthSize: .infinity),
                        icon: viewModel.usernameIcon)
            .submitLabel(.done)
    }

    private var passwordTextField: some View {
        CustomTextField(text: $viewModel.password,
                        placeholderText: viewModel.passwordText,
                        type: .filled(textColor: ColorTheme.foreground.color,
                                      backgroundColor: ColorTheme.textfield.color,
                                      maxWidthSize: .infinity),
                        icon: viewModel.passwordIcon)
            .submitLabel(.done)
    }

    private var loginButton: some View {
        MainButtonView(title: viewModel.loginText,
                       type: .filled(backgroundColor: ColorTheme.button.color,
                                     maxWidthSize: .infinity)) {
            hideKeyboard()
            viewModel.action?()
        }
    }
}

#Preview {
    LoginContainerView(viewModel: LoginContainerViewModel())
}
