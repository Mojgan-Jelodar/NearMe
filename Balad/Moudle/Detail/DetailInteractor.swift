//
//  DetailInteractor.swift
//  Balad
//
//  Created by mozhgan on 3/29/21.
//

import Foundation
protocol I2PDetailProtocol: class {
    func fetched(photos: [Photo])
    func fetched(tips: [Comment])
    func fetched(error: Error)
}
protocol P2IDetailProtocol: class {
    var output: I2PDetailProtocol? { get set }
    func photos(id: String)
    func tips(id: String)
}

final class DetailInteractor: P2IDetailProtocol {

    weak internal var output: I2PDetailProtocol?
    private lazy var dataProvider: VenueDataProvider = {
        return VenueServiceDataProvider(delegate: self)
    }()
    required init(delegate: I2PDetailProtocol ) {
        self.output = delegate
    }

    func photos(id: String) {
        dataProvider.photos(id: id)

    }
    func tips(id: String) {
        dataProvider.tips(id: id)
    }
}

extension DetailInteractor: VenueDataProviderDelegate {
    func fetched(photos: [Photo]) {
        self.output?.fetched(photos: photos)
    }

    func fetched(tips: [Comment]) {
        self.output?.fetched(tips: tips)
    }

    func failedFetchBy(error: Error) {
        self.output?.fetched(error: error)
    }

}
