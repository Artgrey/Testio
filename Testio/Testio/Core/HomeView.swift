//
//  HomeView.swift
//  Testio
//
//  Created by Arturas Krivenkis on 15/10/2024.
//

import SwiftUI

struct HomeView: View {

    @State var isAuthenticated = AppManager.IsAuthenticated

    var body: some View {
        Group {
            isAuthenticated ? AnyView(ServersListView()) : AnyView(LoginView())
        }
        .onReceive(AppManager.Authenticated, perform: {
            isAuthenticated = $0
        })
    }
}

#Preview {
    HomeView()
}
