//
//  LoginContainerViewModel.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import SwiftUI

class LoginContainerViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""

    let usernameText: String = BasicStrings.username
    let passwordText: String = BasicStrings.password
    let loginText: String = BasicStrings.login
    let usernameIcon: Image? = BasicImages.username.image
    let passwordIcon: Image? = BasicImages.password.image
    var action: (() -> Void)?
}
