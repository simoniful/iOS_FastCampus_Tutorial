// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beer = try? newJSONDecoder().decode(Beer.self, from: jsonData)

import Foundation

// MARK: - BeerElement
struct Beer: Codable {
    var id: Int?
    var name, taglineString, firstBrewed, description: String?
    var imageURL: String?
    var abv: Double?
    var ibu: Double?
    var ebc: Double?
    var srm: Double?
    var ph: Double?
    var foodPairing: [String]?
    var brewersTips: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case taglineString = "tagline"
        case firstBrewed = "first_brewed"
        case description 
        case imageURL = "image_url"
        case abv, ibu
        case ebc, srm, ph
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
    
    var tagline: String {
        let tags = taglineString?.components(separatedBy: ". ")
        let hashtags = tags?.map {
            "#" + $0.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: " #")
        }
        return hashtags?.joined(separator: " ") ?? ""
    }
}



