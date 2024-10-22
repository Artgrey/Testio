//
//  ServersViewModel.swift
//  Testio
//
//  Created by Arturas Krivenkis on 16/10/2024.
//

import Foundation
import Combine
import SwiftUI

class ServersViewModel: ObservableObject {

    enum FilterType: CaseIterable {
        case byDistance
        case alphabet

        var text: String {
            switch self {
            case .byDistance:
                return BasicStrings.byDistance
            case .alphabet:
                return BasicStrings.alphabetical
            }
        }
    }

    private let serversService: ServerServiceProtocol

    @Published var showFilter = false
    @Published var serverList: [Server] = []

    let filterButtonText: String = BasicStrings.filter
    let logoutButtonText: String = BasicStrings.logout
    let logoText: String = BasicStrings.logo
    let serverText: String = BasicStrings.server
    let distanceText: String = BasicStrings.distance
    let filterArray: [FilterType] = FilterType.allCases
    let filterIcon: Image? = BasicImages.sort.image
    let logoutIcon: Image? = BasicImages.logout.image

    init(serversService: ServerServiceProtocol = ServerService()) {
        self.serversService = serversService
    }

    func fetchServers() async {
        if let returnedData = try? await serversService.getServers() {
            await MainActor.run {
                serverList.append(contentsOf: returnedData)
            }
        }
    }

    func sortServers(by filter: FilterType) {
        switch filter {
        case .byDistance:
            serverList = serverList.sorted { $0.distance < $1.distance }
        case .alphabet:
            serverList = serverList.sorted { $0.name < $1.name }
        }
    }

    func logoutUser() {
        serverList.removeAll()
        AppManager.deleteToken()
    }
}
