//
//	Icon.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Icon: Object, Decodable {

	@objc dynamic var prefix: String = String()
	@objc dynamic var suffix: String = String()

	enum CodingKeys: String, CodingKey {
		case prefix
		case suffix
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix) ?? ""
        suffix = try values.decodeIfPresent(String.self, forKey: .suffix) ?? ""
	}

}
