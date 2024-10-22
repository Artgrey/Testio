//
//  MainButtonStyle.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Constants {
    struct ButtonStyle {
        static let maxScaleEffect = CGFloat(1.0)
        static let minScaleEffect = CGFloat(0.9)
        static let minOpacity = CGFloat(0.8)
        static let maxOpacity = CGFloat(1.0)
    }
}

struct MainButtonStyle: ButtonStyle {

    let type: ComponentType

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.basic)
            .foregroundStyle(type.textColor)
            .padding(type.paddingSize)
            .background(type.background)
            .scaleEffect(
                configuration.isPressed ? Constants.ButtonStyle.minScaleEffect :
                    Constants.ButtonStyle.maxScaleEffect)
            .opacity(
                configuration.isPressed ? Constants.ButtonStyle.minOpacity :
                    Constants.ButtonStyle.maxOpacity)
    }
}

