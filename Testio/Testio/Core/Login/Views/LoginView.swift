//
//  LoginView.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI
import Combine

extension Constants {
    struct Login {
        static let spacing = CGFloat(40)
        static let padding = CGFloat(30)
        static let logoWidth = CGFloat(186)
        static let logoHeight = CGFloat(48)
    }
}

struct LoginView: View {

    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            backgroundImage

            switch viewModel.loginState {
            case .idle:
                loginContainer
            case .loading:
                ProgressView(viewModel.loadingText)
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $viewModel.showAlert,
               content: {
            Alert(title: Text(viewModel.errorMessageTitle),
                  message: Text(viewModel.errorMessageSubtitle))
        })
    }

    private var backgroundImage: some View {
        VStack {
            Spacer()
            viewModel.backgroundImage?
                .resizable()
                .scaledToFit()
        }
    }

    private var loginContainer: some View {
        VStack(spacing: Constants.Login.spacing) {
            Spacer()
            logoImage

            LoginContainerView(viewModel: viewModel.loginContainerViewModel)
            Spacer()
        }
        .padding(Constants.Login.padding)
        .keyboardResponsive()
    }

    private var logoImage: some View {
        viewModel.logoImage?
            .resizable()
            .frame(width: Constants.Login.logoWidth,
                   height: Constants.Login.logoHeight)
    }
}

#Preview {
    LoginView()
}
