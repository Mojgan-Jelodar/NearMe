//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class User: Object, Decodable {

	@objc dynamic var countryCode: String = String()
	@objc dynamic var firstName: String = String()
	@objc dynamic var gender: String = String()
	@objc dynamic var id: String = String()
	@objc dynamic var lastName: String = String()
	@objc dynamic var photo: Photo?

	enum CodingKeys: String, CodingKey {
		case countryCode
		case firstName
		case gender
		case id
		case lastName
		case photo
	}

    override class func primaryKey() -> String? {
        return "id"
    }

   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode) ?? ""
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? ""
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? ""
		photo = try Photo(from: decoder)
	}

}
