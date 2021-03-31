//
//	Item.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Item: Decodable {

	@objc dynamic var venue: Venue?

	enum CodingKeys: String, CodingKey {
		case venue
	}

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
    }

}
