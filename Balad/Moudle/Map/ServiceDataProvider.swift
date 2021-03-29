//
//  ServiceProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation

final class ServiceDataProvider: DataProvider {
    weak var delegate: DataProviderDelegate?
    private let service = VenueService()
    private lazy var cacheDataProvider: CacheDataProvider = {
        return CacheDataProvider(delegate: self.delegate!)
    }()

    required init(delegate: DataProviderDelegate) {
        self.delegate = delegate
    }

    func fetch(lat: Double, long: Double) {
        self.cacheDataProvider.fetch(lat: lat, long: long)
        service.venues(lat: lat, long: long, success: { [weak self] (place) in
            guard let strongSelf = self else { return }
            let places = place.data?.groups.reduce([Items](), { $0 + ($1.items)}) ?? []
            strongSelf.cacheDataProvider.save(items: Array(places))
            strongSelf.delegate?.fetched(items: places)
        }, failure: { [weak self](error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.failedFetchBy(error: error)

        })

    }
}
