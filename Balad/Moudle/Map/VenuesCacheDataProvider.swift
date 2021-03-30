//
//  CacheProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
import CoreLocation

final class VenuesCacheDataProvider: VenuesDataProvider {
    weak var delegate: DataProviderDelegate?
    private lazy var contextPersist: ContextPersist = {
        let tmp = ContextPersist(strategy: DbPersist())
        return tmp
    }()

    required init(delegate: DataProviderDelegate) {
        self.delegate = delegate
    }

    func fetch(lat: Double, long: Double) {
        let userLocation = CLLocation(latitude: lat, longitude: long)
        self.contextPersist.retrive { [weak self] (items: [Venue]) in
            guard let strongSelf = self else { return }
            let filteredItems = items.filter { (item) -> Bool in
                let venueLocation = CLLocation(latitude: item.location?.lat ?? 0.0,
                                               longitude: item.location?.lng ?? 0)
                            let distanceInMeters = userLocation.distance(from: venueLocation)
                            return distanceInMeters <= 1000
                        }
            strongSelf.delegate?.fetched(items: filteredItems)
        }
    }

    func save(items: [Venue]) {
        do {
            try self.contextPersist.save(objects: items)
        } catch let error {
            self.delegate?.failedFetchBy(error: error)
        }
    }

}
