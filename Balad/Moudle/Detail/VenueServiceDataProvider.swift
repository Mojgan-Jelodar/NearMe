//
//  VenueServiceDataProvider.swift
//  Balad
//
//  Created by mozhgan on 3/30/21.
//

import Foundation
final class VenueServiceDataProvider: VenueDataProvider {
    weak var delegate: VenueDataProviderDelegate?
    private let service = VenueService()
    private lazy var cacheDataProvider: VenueCacheDataProvider = {
        return VenueCacheDataProvider(delegate: self.delegate!)
    }()

    required init(delegate: VenueDataProviderDelegate) {
        self.delegate = delegate
    }

    func photos(id: String) {
        self.cacheDataProvider.photos(id: id)
        service.photos(id: id, success: { [weak self] (response) in
            guard let strongSelf = self else { return }
            guard let photos = response.data?.photos?.items else { return }
            strongSelf.cacheDataProvider.save(id: id, photos: Array(photos))
            strongSelf.cacheDataProvider.photos(id: id)
        }, failure: { [weak self] (error) in
            guard let strongSelf = self else { return }
            print("fetch photos : \(error)")
            strongSelf.cacheDataProvider.photos(id: id)
        })
    }

    func tips(id: String) {
        self.cacheDataProvider.tips(id: id)
        service.tips(id: id, success: { [weak self](response) in
            guard let strongSelf = self else { return }
            guard let tips = response.data?.tips?.items else { return }
            strongSelf.cacheDataProvider.save(id: id, tips: Array(tips))
        }, failure: { [weak self] (error) in
            guard let strongSelf = self else { return }
            print("fetch tips : \(error)")
            strongSelf.delegate?.failedFetchBy(error: error)
        })

    }
}
