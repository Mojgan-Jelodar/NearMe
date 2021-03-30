//
//	Stat.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Stat: Object, Decodable {

	@objc dynamic var checkinsCount: Int = Int()
	@objc dynamic var tipCount: Int = Int()
	@objc dynamic var usersCount: Int = Int()

	enum CodingKeys: String, CodingKey {
		case checkinsCount
		case tipCount
		case usersCount
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        checkinsCount = try values.decodeIfPresent(Int.self, forKey: .checkinsCount) ?? 0
        tipCount = try values.decodeIfPresent(Int.self, forKey: .tipCount) ?? 0
        usersCount = try values.decodeIfPresent(Int.self, forKey: .usersCount) ?? 0
	}

}
