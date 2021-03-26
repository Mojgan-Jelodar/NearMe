//
//  ServiceProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation

final class ServiceDataProvider: DataProvider {
    weak var delegate: DataProviderDelegate?
    private let service = UserLocationService()

    required init(delegate: DataProviderDelegate) {
        self.delegate = delegate
    }

    func fetch(lat: Double, long: Double) {
        service.venues(lat: lat, long: long, success: { [weak self] (place) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.fetched(items: place.response?.groups?.reduce([Items](), { $0 + ($1.items ?? [])}) ?? [])
        }, failure: { [weak self](error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.failedFetchBy(error: error)
        })

    }
}
