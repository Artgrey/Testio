//
//  MainButtonView.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

struct MainButtonView: View {

    private let title: String
    private let leadIcon: Image?
    private let trailIcon: Image?
    private let iconHeight: CGFloat
    private let type: ComponentType
    private let action: () -> Void

    init(
        title: String,
        leadIcon: Image? = nil,
        trailIcon: Image? = nil,
        iconHeight: CGFloat = Constants.iconSize,
        type: ComponentType,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.leadIcon = leadIcon
        self.trailIcon = trailIcon
        self.iconHeight = iconHeight
        self.type = type
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                leadIcon?.makeIcon(height: iconHeight)
                Text(title)
                trailIcon?.makeIcon(height: iconHeight)
            }
            .frame(maxWidth: type.maxWidthSize)
        }
        .withButtonStyle(type: type)
    }
}

#Preview {
    VStack(spacing: 20) {
        MainButtonView(title: "Click me",
                       leadIcon: BasicImages.sort.image,
                       trailIcon: BasicImages.logout.image,
                       type: .filled(textColor: .white,
                                     backgroundColor: .brown,
                                     cornerRadius: 12,
                                     maxWidthSize: 300,
                                     paddingSize: .init(top: 12,
                                                        leading: 12,
                                                        bottom: 12,
                                                        trailing: 12)),
                       action: {})
        MainButtonView(title: "Click me 2",
                       type: .filled(),
                       action: {})
        MainButtonView(title: "Click me 3",
                       type: .outlined(),
                       action: {})
    }
    .padding()
}
