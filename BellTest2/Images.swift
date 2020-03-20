
import Foundation
struct Images : Codable {
	let type : String?
	let url : String?
	let width : Int?
	let height : Int?

	enum CodingKeys: String, CodingKey {

		case type = "Type"
		case url = "Url"
		case width = "Width"
		case height = "Height"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
	}

}
