//
//  FoursquareApi.swift
//  Balad
//
//  Created by mozhgan on 3/11/21.
//

import Moya
struct  VenueService {
    private let provider = MoyaProvider<VenueApi>(plugins: [NetworkLoggerPlugin()])

    func photos(id: String,
                success :@escaping (BaseResponse<PhotosResponse>) -> Void,
                failure :@escaping (Error) -> Void) {
        provider.request(VenueApi.photos(id: id)) { result in
            switch result {
            case .success(let response) :
                do {
                    let output = try response.mapObject(BaseResponse<PhotosResponse>.self)
                    success(output)
                } catch {
                    failure(error)
                }
            case .failure(let error) :
                failure(error)
            }
        }
    }
    func tips(id: String,
              success :@escaping (BaseResponse<TipsResponse>) -> Void,
              failure :@escaping (Error) -> Void) {
        provider.request(VenueApi.tips(id: id)) { result in
            switch result {
            case .success(let response) :
                do {
                    let output = try response.mapObject(BaseResponse<TipsResponse>.self)
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
