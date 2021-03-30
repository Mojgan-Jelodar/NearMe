//
//  TipsResponse.swift
//  Balad
//
//  Created by mozhgan on 3/30/21.
//

import Foundation

struct TipsResponse: Decodable {
    let tips: Tips?

    enum CodingKeys: String, CodingKey {
        case tips
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tips = try values.decodeIfPresent(Tips.self, forKey: .tips)
    }

}
