import SwiftData

@Model
class ServersData {
    let name: String
    let distance: Int

    init(name: String, distance: Int) {
        self.name = name
        self.distance = distance
    }
}
