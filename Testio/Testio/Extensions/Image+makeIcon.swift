//
//  Image+makeIcon.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Image {
    /// Makes icon from image
    func makeIcon(height: CGFloat = Constants.iconSize) -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(height: height)
    }
}
