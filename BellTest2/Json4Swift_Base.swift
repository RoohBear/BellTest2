

import Foundation
struct Json4Swift_Base : Codable
{
	let id : Int?
	let name : String?
	let desc : String?
	let shortDesc : String?
	let type : String?
	let owner : Owner?
	let episode : String?
	let agvotCode : String?
	let agvotDisclaimer : String?
	let qfrCode : String?
	let airingOrder : String?
	let broadcastDate : String?
	let broadcastTime : String?
	let broadcastDateTime : String?
	let lastModifiedDateTime : String?      // having this as a Date object SHOULD work, but I get "typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "LastModifiedDateTime", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil)" errors by the Parsing library for some reason, so we'll leave it as a string for now
	let gameId : String?
	let album : String?
	let genres : [String]?
	let Keywordswords : [String]?
	let tags : [String]?
	let images : [Images]?
	let authentication : Authentication?
	let nextAuthentication : String?
	let ratingWarnings : [String]?
	let people : [String]?
	let funding : String?
	let musicLabels : [String]?
	let broadcastNetworks : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "Id"
		case name = "Name"
		case desc = "Desc"
		case shortDesc = "ShortDesc"
		case type = "Type"
		case owner = "Owner"
		case episode = "Episode"
		case agvotCode = "AgvotCode"
		case agvotDisclaimer = "AgvotDisclaimer"
		case qfrCode = "QfrCode"
		case airingOrder = "AiringOrder"
		case broadcastDate = "BroadcastDate"
		case broadcastTime = "BroadcastTime"
		case broadcastDateTime = "BroadcastDateTime"
		case lastModifiedDateTime = "LastModifiedDateTime"
		case gameId = "GameId"
		case album = "Album"
		case genres = "Genres"
		case Keywordswords = "Keywords"
		case tags = "Tags"
		case images = "Images"
		case authentication = "Authentication"
		case nextAuthentication = "NextAuthentication"
		case ratingWarnings = "RatingWarnings"
		case people = "People"
		case funding = "Funding"
		case musicLabels = "MusicLabels"
		case broadcastNetworks = "BroadcastNetworks"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		desc = try values.decodeIfPresent(String.self, forKey: .desc)
		shortDesc = try values.decodeIfPresent(String.self, forKey: .shortDesc)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
		episode = try values.decodeIfPresent(String.self, forKey: .episode)
		agvotCode = try values.decodeIfPresent(String.self, forKey: .agvotCode)
		agvotDisclaimer = try values.decodeIfPresent(String.self, forKey: .agvotDisclaimer)
		qfrCode = try values.decodeIfPresent(String.self, forKey: .qfrCode)
		airingOrder = try values.decodeIfPresent(String.self, forKey: .airingOrder)
		broadcastDate = try values.decodeIfPresent(String.self, forKey: .broadcastDate)
		broadcastTime = try values.decodeIfPresent(String.self, forKey: .broadcastTime)
		broadcastDateTime = try values.decodeIfPresent(String.self, forKey: .broadcastDateTime)
		lastModifiedDateTime = try values.decodeIfPresent(String.self, forKey: .lastModifiedDateTime)
		gameId = try values.decodeIfPresent(String.self, forKey: .gameId)
		album = try values.decodeIfPresent(String.self, forKey: .album)
		genres = try values.decodeIfPresent([String].self, forKey: .genres)
        Keywordswords = try values.decodeIfPresent([String].self, forKey: .Keywordswords)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		images = try values.decodeIfPresent([Images].self, forKey: .images)
		authentication = try values.decodeIfPresent(Authentication.self, forKey: .authentication)
		nextAuthentication = try values.decodeIfPresent(String.self, forKey: .nextAuthentication)
		ratingWarnings = try values.decodeIfPresent([String].self, forKey: .ratingWarnings)
		people = try values.decodeIfPresent([String].self, forKey: .people)
		funding = try values.decodeIfPresent(String.self, forKey: .funding)
		musicLabels = try values.decodeIfPresent([String].self, forKey: .musicLabels)
		broadcastNetworks = try values.decodeIfPresent([String].self, forKey: .broadcastNetworks)
	}

}
