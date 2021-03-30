//
//	Category.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Category: Object, Decodable {

	@objc dynamic var icon: Icon?
	@objc dynamic var id: String! = String()
	@objc dynamic var name: String = String()
	@objc dynamic var pluralName: String = String()
	@objc dynamic var primary: Bool = Bool()
	@objc dynamic var shortName: String = String()
	enum CodingKeys: String, CodingKey {
		case icon
		case id
		case name
		case pluralName
		case primary
		case shortName
	}

    override class func primaryKey() -> String? {
        return "id"
    }
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon = try Icon(from: decoder)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        pluralName = try values.decodeIfPresent(String.self, forKey: .pluralName) ?? ""
        primary = try values.decodeIfPresent(Bool.self, forKey: .primary) ?? false
        shortName = try values.decodeIfPresent(String.self, forKey: .shortName) ?? ""
	}
}
