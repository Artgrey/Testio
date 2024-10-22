//
//  CustomTextField.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Constants {
    struct CustomTextField {
        static let minTextColorOpacity = CGFloat(0.3)
        static let maxTextColorOpacity = CGFloat(0.6)
    }
}

struct CustomTextField: View {

    @Binding var text: String
    @FocusState var isFocused: Bool

    private let placeholderText: String
    private let type: ComponentType
    private let icon: Image?

    init(text: Binding<String>,
         placeholderText: String = "",
         type: ComponentType,
         icon: Image? = nil) {
        self._text = text
        self.placeholderText = placeholderText
        self.type = type
        self.icon = icon
    }

    var body: some View {
        TextField(
            placeholderText,
            text: $text,
            prompt:
                Text(placeholderText)
                    .foregroundStyle(type.textColor
                        .opacity(isFocused ? Constants.CustomTextField.minTextColorOpacity :
                                        Constants.CustomTextField.maxTextColorOpacity)
                    )
        )
        .frame(maxWidth: type.maxWidthSize)
        .withTextFieldStyle(type: type, icon: icon)
        .focused($isFocused)
    }
}

#Preview {
    VStack {
        CustomTextField(text: .constant(""),
                        placeholderText: "Search",
                        type: .filled())

        CustomTextField(text: .constant(""), 
                        placeholderText: "Search",
                        type: .outlined(), 
                        icon: Image(systemName: "eye"))

        CustomTextField(text: .constant(""), 
                        placeholderText: "Search",
                        type: .filled(textColor: ColorTheme.foreground.color,
                                      backgroundColor: ColorTheme.textfield.color,
                                      cornerRadius: 20,
                                      maxWidthSize: 300, 
                                      paddingSize: .init(top: 12,
                                                         leading: 8,
                                                         bottom: 12,
                                                         trailing: 8)),
                        icon: BasicImages.username.image)
    }
}
