import Foundation

struct Note: Identifiable, Codable {
    let id = UUID()
    var content: String
}
