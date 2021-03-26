//
//  FoursquareApi.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
struct  UserLocationService {
    private let provider = MoyaProvider<VenuesApi>(plugins: [NetworkLoggerPlugin()])
    private let clientId = "XXXX"
    private let clientSecret = "XXXX"

    func venues(lat: Double,
                long: Double,
                success :@escaping (Place) -> Void,
                failure :@escaping (Error) -> Void) {
        provider.request(VenuesApi.explore(lag: lat, long: long)) { result in
            switch result {
            case .success(let response) :
                do {
                    let output = try response.mapObject(Place.self)
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
