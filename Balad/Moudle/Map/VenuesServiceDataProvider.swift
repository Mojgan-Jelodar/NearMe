//
//  ServiceProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation

final class VenuesServiceDataProvider: VenuesDataProvider {
    weak var delegate: DataProviderDelegate?
    private let service = VenuesService()
    private lazy var cacheDataProvider: VenuesCacheDataProvider = {
        return VenuesCacheDataProvider(delegate: self.delegate!)
    }()

    required init(delegate: DataProviderDelegate) {
        self.delegate = delegate
    }

    func fetch(lat: Double, long: Double) {
        self.cacheDataProvider.fetch(lat: lat, long: long)
        service.explore(lat: lat, long: long, success: { [weak self] (place) in
            guard let strongSelf = self else { return }
            let places = place.data?.groups.reduce([Item](), { $0 + ($1.items)}) ?? []
            strongSelf.cacheDataProvider.save(items: Array(places.map({$0.venue!.detached()})))
            strongSelf.cacheDataProvider.fetch(lat: lat, long: long)
        }, failure: { [weak self](error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.failedFetchBy(error: error)

        })
    }
}
