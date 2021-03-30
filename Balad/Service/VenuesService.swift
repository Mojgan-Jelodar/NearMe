//
//  FoursquareApi.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
struct  VenuesService {
    private let provider = MoyaProvider<VenuesApi>(plugins: [NetworkLoggerPlugin()])

    func explore(lat: Double,
                 long: Double,
                 success :@escaping (BaseResponse<PlacesResponse>) -> Void,
                 failure :@escaping (Error) -> Void) {
        provider.request(VenuesApi.explore(lag: lat, long: long)) { result in
            switch result {
            case .success(let response) :
                do {
                    let output = try response.mapObject(BaseResponse<PlacesResponse>.self)
                    success(output)
                } catch {
                    failure(error)
                }
            case .failure(let error) :
                failure(error)
            }
        }
    }

}
