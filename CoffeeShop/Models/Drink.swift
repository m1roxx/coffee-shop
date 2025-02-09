import FirebaseFirestore

struct Drink: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let description: String
    let price: Double
    let imageURL: String 
    let category: DrinkCategory
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageURL
        case category
    }
}

enum DrinkCategory: String, Codable, CaseIterable {
    case hot = "Hot Coffee"
    case cold = "Cold Coffee"
    case tea = "Tea"
    case special = "Specials"
}
