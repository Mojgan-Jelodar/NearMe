//
//  Foursquare.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
import Foundation

enum VenuesApi {
    case explore(lag: Double, long: Double)

}
extension VenuesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.foursquare.com/v2/venues")!
    }

    var path: String {
        switch self {
        case .explore:
            return "/explore"
        }
    }
    var method: Moya.Method {
        switch self {
        case .explore:
            return Method.get
        }
    }
    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json;charset=utf-8"]
    }

    var task: Task {
        switch self {
        case .explore(let lat, let long):
            return .requestParameters(parameters: [//"client_id" : Api.clientId,
                                                   //"client_secret" : Api.clientSecret,
                                                   "oauth_token": "AIAPJ3MVNR0FRSU2VLINIR0YJCQM521TZSOB2WW4CJA5YOQC",
                                                   "ll": "\(lat),\(long)",
                                                   "radius": "2000",
                                                   "v": 20210326], encoding: URLEncoding.queryString)
        }
    }

}
