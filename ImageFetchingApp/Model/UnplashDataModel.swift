import Foundation

// MARK: - UnsplashStruct
struct UnsplashStruct: Codable {
    let total, totalPages: Int?
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String?
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small, thumb: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}
