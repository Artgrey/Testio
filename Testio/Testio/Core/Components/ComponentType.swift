//
//  MainButtonType.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Constants {
    struct Component {
        static let padding = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
    }
}

enum ComponentType {
    case filled(textColor: Color = .white,
                backgroundColor: Color = .black,
                cornerRadius: CGFloat = Constants.cornerRadius,
                maxWidthSize: CGFloat? = nil,
                paddingSize: EdgeInsets = Constants.Component.padding)

    case outlined(textColor: Color = .black,
                  backgroundColor: Color = .white,
                  cornerRadius: CGFloat = Constants.cornerRadius,
                  maxWidthSize: CGFloat? = nil,
                  paddingSize: EdgeInsets = Constants.Component.padding)

    var borderRadius: CGFloat {
        switch self {
        case .filled(_, _, let cornerRadius, _, _), .outlined(_, _, let cornerRadius, _, _):
            return cornerRadius
        }
    }

    var backgroundColor: Color {
        switch self {
        case .filled(_, let backgroundColor, _, _, _), .outlined(_, let backgroundColor, _, _, _):
            return backgroundColor
        }
    }

    var textColor: Color {
        switch self {
        case .filled(let textColor, _, _, _, _), .outlined(let textColor, _, _, _, _):
            return textColor
        }
    }

    var paddingSize: EdgeInsets {
        switch self {
        case .filled(_, _, _, _, let padding), .outlined(_, _, _, _, let padding):
            return padding
        }
    }

    var maxWidthSize: CGFloat? {
        switch self {
        case .filled(_, _, _, let maxWidthSize, _), .outlined(_, _, _, let maxWidthSize, _):
            return maxWidthSize
        }
    }

    @ViewBuilder
    var background: some View {
        switch self {
        case .filled:
            RoundedRectangle(cornerRadius: borderRadius).fill(backgroundColor)
        case .outlined:
            RoundedRectangle(cornerRadius: borderRadius).stroke(textColor)
        }
    }
}
