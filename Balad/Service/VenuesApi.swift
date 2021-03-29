//
//  Foursquare.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
import Foundation
import Alamofire

enum VenuesApi {
    var version: Int {
        return 20210326
    }
    var token: String {
        return "AIAPJ3MVNR0FRSU2VLINIR0YJCQM521TZSOB2WW4CJA5YOQC"
    }

    case explore(lag: Double, long: Double)
    case photo(id: String)

}
extension VenuesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.foursquare.com/v2/venues")!
    }

    var path: String {
        switch self {
        case .explore:
            return "/explore"
        case .photo(let id):
            return "/\(id)/photos"
        }
    }
    var method: Moya.Method {
        switch self {
        default :
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
            return .requestParameters(parameters: ["oauth_token": token,
                                                   "ll": "\(lat),\(long)",
                                                   "radius": "5000",
                                                   "limit": 50,
                                                   "v": version], encoding: URLEncoding.queryString)
        case .photo:
            return .requestParameters(parameters: ["oauth_token": token,
                                                   "v": version], encoding: URLEncoding.queryString)
        }
    }

}
