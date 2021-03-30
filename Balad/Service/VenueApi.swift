//
//  Foursquare.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
import Foundation
import Alamofire

enum VenueApi {

    case photos(id: String)
    case tips(id: String)

}
extension VenueApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.foursquare.com/v2/venues")!
    }

    var path: String {
        switch self {
        case .tips(id: let id):
            return "/\(id)/tips"
        case .photos(let id):
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
        case .tips:
            return .requestParameters(parameters: ["oauth_token": Constant.token,
                                                   "v": Constant.version,
                                                   "sort": "recent",
                                                   "offset": 0,
                                                   "limit": 100], encoding: URLEncoding.queryString)
        case .photos:
            return .requestParameters(parameters: ["oauth_token": Constant.token,
                                                   "v": Constant.version], encoding: URLEncoding.queryString)
        }
    }

}
