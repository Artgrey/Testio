//
//  CustomTextFieldStyle.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Constants {
    struct TextFieldStyle {
        static let minTextColorOpacity = CGFloat(0.6)
        static let maxTextColorOpacity = CGFloat(1.0)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {

    @FocusState var isFocused:Bool
    @State var icon: Image?
    let type: ComponentType

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            icon?
                .makeIcon()
                .foregroundColor(type.textColor
                    .opacity(isFocused ? Constants.TextFieldStyle.maxTextColorOpacity :
                                Constants.TextFieldStyle.minTextColorOpacity))
            configuration
                        .focused($isFocused)
        }
        .font(Font.basic)
        .foregroundStyle(type.textColor)
        .padding(type.paddingSize)
        .background(type.background)
        .autocapitalization(.none)
        .autocorrectionDisabled()
    }
}
