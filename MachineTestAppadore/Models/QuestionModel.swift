import Foundation

// MARK: - Models
struct Question: Codable, Identifiable {
    
    let answerId: Int
    let countries: [Country]
    let countryCode: String
    var id: Int { answerId }
    
    
    enum CodingKeys: String, CodingKey {
        case answerId = "answer_id"
        case countries
        case countryCode = "country_code"
    }
}

struct Country: Codable, Identifiable {
    let id: Int
    let countryName: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryName = "country_name"
    }
}

struct QuestionData: Codable {
    let questions: [Question]
}
