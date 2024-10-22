//
//  ServersListView.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import SwiftUI
import SwiftData

extension Constants {
    struct ServersList {
        static let topButtonPadding = EdgeInsets(top: 0, leading: 12,
                                                 bottom: 0, trailing: 12)
        static let listVerticalPadding = CGFloat(10)
        static let listRowInsets = EdgeInsets(top: 0, leading: 18,
                                              bottom: 0, trailing: 18)
    }
}

struct ServersListView: View {

    @ObservedObject var viewModel = ServersViewModel()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            topBarView

            serversListView
        }
        .task {
            await viewModel.fetchServers()
            addServersToModelData()
        }
    }

    private var topBarView: some View {
        HStack {
            filterButton

            Spacer()

            Text(viewModel.logoText)
                .font(.header)
                .frame(maxWidth: .infinity)

            Spacer()

            logoutButton
        }
    }

    private var filterButton: some View {
        MainButtonView(
            title: viewModel.filterButtonText,
            leadIcon: viewModel.filterIcon,
            type: .filled(textColor: ColorTheme.button.color,
                          backgroundColor: ColorTheme.background.color,
                          paddingSize: Constants.ServersList.topButtonPadding)
        ) {
            viewModel.showFilter.toggle()
        }
            .confirmationDialog("",
                                isPresented: $viewModel.showFilter,
                                titleVisibility: .hidden) {
                ForEach(viewModel.filterArray, id: \.self) { filter in
                    Button {
                        viewModel.sortServers(by: filter)
                    } label: {
                        Text(filter.text)
                    }
                }
            }
    }

    private var logoutButton: some View {
        MainButtonView(title: viewModel.logoutButtonText,
                       trailIcon: viewModel.logoutIcon,
                       type: .filled(textColor: ColorTheme.button.color,
                                     backgroundColor: ColorTheme.background.color,
                                     paddingSize: Constants.ServersList.topButtonPadding)) {
            viewModel.logoutUser()
            deleteServersFromModelData()
        }
    }

    private var serversListView: some View {
        List {
            Section(
                header: setRow(viewModel.serverText,
                               viewModel.distanceText)
            ) {
                ForEach(viewModel.serverList, id: \.self) { data in
                    setRow(data.name,
                           data.distanceText)
                    .padding(.vertical, Constants.ServersList.listVerticalPadding)
                    .listRowInsets(Constants.ServersList.listRowInsets)
                }
            }
        }
        .listStyle(.grouped)
    }

    private func setRow(_ textOne: String,_ textTwo: String) -> some View {
        HStack {
            Text(textOne)
            Spacer()
            Text(textTwo)
        }
    }

    private func addServersToModelData() {
        for server in viewModel.serverList {
            let serversData = ServersData(name: server.name, 
                                          distance: server.distance)
            modelContext.insert(serversData)
        }
        saveModelContext()
    }

    private func deleteServersFromModelData() {
        for server in viewModel.serverList {
            let serversData = ServersData(name: server.name, 
                                          distance: server.distance)
            modelContext.delete(serversData)
        }
        saveModelContext()
    }

    private func saveModelContext() {
        do {
            try modelContext.save()
            print("Success in saving servers")
        } catch {
            print("Failed to save servers: \(error)")
        }
    }
}

#Preview {
    ServersListView()
}
