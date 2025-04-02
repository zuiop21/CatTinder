struct Cat: Hashable, Codable, Identifiable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let breeds: [Breed]?
    var userId: String?
}
