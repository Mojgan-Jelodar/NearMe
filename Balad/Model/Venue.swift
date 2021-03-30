//
//	Venue.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Venue: Object, Decodable {

	@objc dynamic var allowMenuUrlEdit: Bool = Bool()
	@objc dynamic var contact: Contact?
	@objc dynamic var hours: Hour?
	@objc dynamic var id: String!
	@objc dynamic var location: Location?
	@objc dynamic var name: String = String()
	@objc dynamic var photos: Photo?
	@objc dynamic var popularityByGeo: Float = Float()
	@objc dynamic var rating: Float = Float()
	@objc dynamic var ratingColor: String = String()
	@objc dynamic var ratingSignals: Int = Int()
	@objc dynamic var stats: Stat?
	@objc dynamic var verified: Bool = Bool()

    var categories = List<Category>()

	enum CodingKeys: String, CodingKey {
		case allowMenuUrlEdit
		case categories
		case contact
		case hours
		case id
		case location
		case name
		case photos
		case popularityByGeo
		case rating
		case ratingColor
		case ratingSignals
		case stats
		case verified
	}

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        popularityByGeo = try values.decodeIfPresent(Float.self, forKey: .popularityByGeo) ?? 0.0
        verified = try values.decodeIfPresent(Bool.self, forKey: .verified) ?? true
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        contact = try values.decodeIfPresent(Contact.self, forKey: .contact)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        stats = try values.decodeIfPresent(Stat.self, forKey: .stats)
        allowMenuUrlEdit = try values.decodeIfPresent(Bool.self, forKey: .allowMenuUrlEdit) ?? true
        hours = try values.decodeIfPresent(Hour.self, forKey: .hours)
        rating = try values.decodeIfPresent(Float.self, forKey: .rating) ?? 0
        ratingColor = try values.decodeIfPresent(String.self, forKey: .ratingColor) ?? "#ffffff"
        ratingSignals = try values.decodeIfPresent(Int.self, forKey: .ratingSignals) ?? 0
        let cpy = try values.decodeIfPresent([Category].self, forKey: .categories)
        categories.append(objectsIn: cpy ?? [])
    }

}
