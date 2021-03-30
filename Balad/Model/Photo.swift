//
//	Photo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Photo: Object, Decodable {

	@objc dynamic var createdAt: Int = Int()
	@objc dynamic var height: Int = Int()
	@objc dynamic var id: String = String()
	@objc dynamic var prefix: String = String()
	@objc dynamic var suffix: String = String()
	@objc dynamic var visibility: String = String()
	@objc dynamic var width: Int = Int()
	@objc dynamic var count: Int = Int()
    @objc dynamic var venue: Venue?

	enum CodingKeys: String, CodingKey {
		case createdAt
		case height
		case id
		case prefix
		case suffix
		case visibility
		case width
		case count
	}

    override class func primaryKey() -> String? {
        return "id"
    }
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt) ?? 0
        height = try values.decodeIfPresent(Int.self, forKey: .height) ?? 0
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix) ?? ""
        suffix = try values.decodeIfPresent(String.self, forKey: .suffix) ?? ""
        visibility = try values.decodeIfPresent(String.self, forKey: .visibility) ?? ""
        width = try values.decodeIfPresent(Int.self, forKey: .width) ?? 0
        count = try values.decodeIfPresent(Int.self, forKey: .count) ?? 0
	}

}
