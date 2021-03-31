//
//  VenueCacheDataProvider.swift
//  Balad
//
//  Created by mozhgan on 3/30/21.
//

import Foundation
import RealmSwift
final class VenueCacheDataProvider: VenueDataProvider {
    deinit {
        print("Deinit was called :\(VenuesServiceDataProvider.self)")
    }
    weak var delegate: VenueDataProviderDelegate?
    private lazy var contextPersist: ContextPersist = {
        let tmp = ContextPersist(strategy: DbPersist())
        return tmp
    }()
    required init(delegate: VenueDataProviderDelegate) {
        self.delegate = delegate
    }

    func photos(id: String) {
        contextPersist.retrive(Photo.self,
                               predicate: NSPredicate(format: " venue.id = %@", id),
                               sorted: Sorted(key: "createdAt", ascending: true)) { (result) in
            self.delegate?.fetched(photos: result)

        }

    }

    func tips(id: String) {
        contextPersist.retrive(Comment.self,
                               predicate: NSPredicate(format: " venue.id = %@", id),
                               sorted: Sorted(key: "createdAt", ascending: true)) { (result) in
            self.delegate?.fetched(tips: Array(result) )

        }

    }

    func save(id: String, tips: [Comment]) {

        contextPersist.retrive(Venue.self,
                               predicate: NSPredicate(format: "id == %@", id),
                               sorted: nil) { (result) in
            guard let venue = result.first else {
                return
            }
            let cpy: [Comment] = tips.map { (tip) -> Comment in
                tip.venue = venue
                return tip
            }
            try? contextPersist.save(objects: cpy)
        }
    }

    func save(id: String, photos: [Photo]) {
        contextPersist.retrive(Venue.self,
                               predicate: NSPredicate(format: "id == %@", id),
                               sorted: nil) { (result) in
            guard let venue = result.first else {
                return
            }
            let cpy: [Photo] = photos.map { (photo) -> Photo in
                photo.venue = venue
                return photo
            }
            try? contextPersist.save(objects: cpy)
        }

    }
}
