import SwiftUI

struct Target: Hashable {
    let uuid: UUID
    var name: String
    var startDate: String
    var endDate: String
    var description: String
    var status: Status
    var label: Label
}

struct Status: Hashable {
    let id: Int
    var name: String
    var color: Color
}

struct Label: Hashable {
    let id: Int
    var name: String
    var color: Color
}
