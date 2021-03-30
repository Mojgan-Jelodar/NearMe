//
//	Contact.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Contact: Object, Decodable {

	@objc dynamic var formattedPhone: String = String()
	@objc dynamic var phone: String = String()

	enum CodingKeys: String, CodingKey {
		case formattedPhone
		case phone
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        formattedPhone = try values.decodeIfPresent(String.self, forKey: .formattedPhone) ?? "-"
        phone = try values.decodeIfPresent(String.self, forKey: .phone) ?? "-"
	}

}
