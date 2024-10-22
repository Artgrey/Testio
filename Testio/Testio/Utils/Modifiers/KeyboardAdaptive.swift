//
//  KeyboardAdaptive.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import SwiftUI
import Combine

extension Constants {
    struct Keyboard {
        static let animationDuration = CGFloat(0.3)
    }
}

struct KeyboardAdaptive: ViewModifier {
    @StateObject private var keyboard = KeyboardResponder()

    func body(content: Content) -> some View {
        content
            .offset(y: -keyboard.keyboardHeight / 3)
            .animation(.easeOut(duration: Constants.Keyboard.animationDuration), value: 1)
    }
}

final private class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .sink { [weak self] notification in
                self?.handleKeyboard(notification: notification)
            }
    }

    deinit {
        cancellable?.cancel()
    }

    private func handleKeyboard(notification: Notification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                withAnimation {
                    keyboardHeight = keyboardFrame.height
                }
            }
        } else {
            withAnimation {
                keyboardHeight = 0
            }
        }
    }
}
