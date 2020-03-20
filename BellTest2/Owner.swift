

import Foundation
struct Owner : Codable {

	enum CodingKeys: CodingKey {

	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
	}

}
