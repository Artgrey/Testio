//
//  URL+Helper.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

extension String {
    var url: URL? {
        URL(string: self)
    }
}
