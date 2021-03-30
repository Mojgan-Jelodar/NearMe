//
//  VenueDataProvider.swift
//  Balad
//
//  Created by mozhgan on 3/30/21.
//

import Foundation
protocol VenueDataProviderDelegate: class {
    func fetched(photos: [Photo])
    func fetched(tips: [Comment])
    func failedFetchBy(error: Error)
}
protocol VenueDataProvider: class {
    var delegate: VenueDataProviderDelegate? { get set}
    func photos(id: String)
    func tips(id: String)
}
