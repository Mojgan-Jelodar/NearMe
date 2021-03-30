//
//	Group.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

@objcMembers  class Group: Decodable {

    var items: [Item] = []
	var name: String = String()
	var type: String = String()

	enum CodingKeys: String, CodingKey {
		case items
		case name
		case type
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        items = try values.decodeIfPresent([Item].self, forKey: .items) ?? []
	}

}
