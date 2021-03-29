//
//  DetailInteractor.swift
//  Balad
//
//  Created by mozhgan on 3/29/21.
//

import Foundation
protocol I2PDetailProtocol: class {
    func fetched(photos: Photos)
    func fetched(error: Error)
}
protocol P2IDetailProtocol: class {
    var output: I2PDetailProtocol? { get set }
    func photo(id: String)
}

final class DetailInteractor: P2IDetailProtocol {
    weak internal var output: I2PDetailProtocol?
    private let venueService = VenueService()
    required init(delegate: I2PDetailProtocol ) {
        self.output = delegate
    }

    func photo(id: String) {
        venueService.photo(id: id) { [weak self] (response: BaseResponse<PhotoResponse>) in
            guard let strongSelf  = self,
                  let photos = response.data?.photos else { return}
            strongSelf.output?.fetched(photos: photos)
        } failure: { [weak self](error) in
            guard let strongSelf  = self else { return}
            strongSelf.output?.fetched(error: error)
        }

    }
}
