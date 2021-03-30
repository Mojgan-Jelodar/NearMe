//
//  Tips.swift
//  Balad
//
//  Created by mozhgan on 3/30/21.
//

import Foundation
import RealmSwift
@objcMembers class Tips: Object, Decodable {
    dynamic var  count: Int?
    var  items = List<Comment>()

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        let cpy = try values.decodeIfPresent([Comment].self, forKey: .items)
        items.append(objectsIn: cpy ?? [])
    }

}
