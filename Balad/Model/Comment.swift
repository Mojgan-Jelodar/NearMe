//
//	Tip.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Comment: Object, Decodable {

	@objc dynamic var agreeCount: Int = Int()
	@objc dynamic var canonicalUrl: String = String()
	@objc dynamic var createdAt: Int = Int()
	@objc dynamic var disagreeCount: Int = Int()
	@objc dynamic var id: String = String()
	@objc dynamic var logView: Bool = Bool()
	@objc dynamic var photo: Photo?
	@objc dynamic var photourl: String = String()
	@objc dynamic var text: String = String()
	@objc dynamic var type: String = String()
	@objc dynamic var user: User?
    @objc dynamic var venue: Venue?

	enum CodingKeys: String, CodingKey {
		case agreeCount
		case canonicalUrl
		case createdAt
		case disagreeCount
		case id
		case logView
		case photo
		case photourl
		case text
		case type
		case user
	}

    override class func primaryKey() -> String? {
        return "id"
    }
   required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
        agreeCount = try values.decodeIfPresent(Int.self, forKey: .agreeCount) ?? 0
        canonicalUrl = try values.decodeIfPresent(String.self, forKey: .canonicalUrl) ?? ""
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt) ?? 0
        disagreeCount = try values.decodeIfPresent(Int.self, forKey: .disagreeCount) ?? 0
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        logView = try values.decodeIfPresent(Bool.self, forKey: .logView) ?? false
		photo = try Photo(from: decoder)
        photourl = try values.decodeIfPresent(String.self, forKey: .photourl) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
		user = try User(from: decoder)
	}

}
