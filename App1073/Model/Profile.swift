import SwiftUI

struct Profile {
    var image: Data?
    var name: String
    var age: String
    var target: String
}

struct Motivate: Hashable {
    let id: Int
    var favorite: Bool
    let image: String
    var date: String
}
