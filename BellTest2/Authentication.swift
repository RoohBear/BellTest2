
import Foundation

struct Authentication : Codable {
	let required : Bool?
	let resources : [Resources]?

	enum CodingKeys: String, CodingKey {

		case required = "Required"
		case resources = "Resources"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		required = try values.decodeIfPresent(Bool.self, forKey: .required)
		resources = try values.decodeIfPresent([Resources].self, forKey: .resources)
	}

}
