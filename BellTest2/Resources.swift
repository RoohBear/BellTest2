
import Foundation
struct Resources : Codable {
	let resourceCode : String?

	enum CodingKeys: String, CodingKey {

		case resourceCode = "ResourceCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resourceCode = try values.decodeIfPresent(String.self, forKey: .resourceCode)
	}

}
