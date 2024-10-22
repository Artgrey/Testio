struct Server: Codable, Hashable {
    let name: String
    let distance: Int
}

extension Server {
    var distanceText: String {
        String(distance)
    }
}
