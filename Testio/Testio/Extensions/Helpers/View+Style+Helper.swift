//
//  View+ButtonStyle+Helper.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension View {
    func withButtonStyle(type: ComponentType) -> some View {
        buttonStyle(MainButtonStyle(type: type))
    }

    func withTextFieldStyle(type: ComponentType, icon: Image? = nil) -> some View {
        textFieldStyle(CustomTextFieldStyle(icon: icon, type: type))
    }
}
