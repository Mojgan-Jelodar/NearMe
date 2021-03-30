//
//	Location.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import RealmSwift

class Location: Object, Decodable {

	@objc dynamic var address: String = String()
	@objc dynamic var cc: String = String()
	@objc dynamic var city: String = String()
	@objc dynamic var country: String = String()
	@objc dynamic var distance: Int = Int()
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lng: Double = 0.0
	@objc dynamic var neighborhood: String = String()
	@objc dynamic var postalCode: String = String()
	@objc dynamic var state: String = String()
    var formattedAddress = List<String>()

	enum CodingKeys: String, CodingKey {
		case address
		case cc
		case city
		case country
		case distance
		case formattedAddress
		case lat
		case lng
		case neighborhood
		case postalCode
		case state
	}
   required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        cc = try values.decodeIfPresent(String.self, forKey: .cc) ?? ""
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        distance = try values.decodeIfPresent(Int.self, forKey: .distance) ?? 0
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
        lng = try values.decodeIfPresent(Double.self, forKey: .lng) ?? 0.0
        neighborhood = try values.decodeIfPresent(String.self, forKey: .neighborhood) ?? ""
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
        state = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        let cpy = try values.decodeIfPresent([String].self, forKey: .formattedAddress) ?? []
        formattedAddress.append(objectsIn: cpy)
	}

}
