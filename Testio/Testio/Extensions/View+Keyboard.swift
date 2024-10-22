//
//  View+Keyboard.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import SwiftUI

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardAdaptive> {
        return modifier(KeyboardAdaptive())
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
