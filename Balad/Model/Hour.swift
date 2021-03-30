//
//	Hour.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Hour: Object, Decodable {

	@objc dynamic var isLocalHoliday: Bool = Bool()
	@objc dynamic var isOpen: Bool = Bool()

	enum CodingKeys: String, CodingKey {
		case isLocalHoliday
		case isOpen
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        isLocalHoliday = try values.decodeIfPresent(Bool.self, forKey: .isLocalHoliday) ?? false
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen) ?? false
	}

}
