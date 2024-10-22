//
//  Font+Helper.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension Font {
    static var basic: Font {
        Font.system(size: 17)
    }

    static var header: Font {
        Font.system(size: 17, weight: Font.Weight.heavy)
    }

    static var loading: Font {
        Font.system(size: 13)
    }
}
