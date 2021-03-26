//
//  CacheProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
final class CacheDataProvider: DataProvider {
    weak var delegate: DataProviderDelegate?

    required init(delegate: DataProviderDelegate) {
        self.delegate = delegate
    }

    func fetch(lat: Double, long: Double) {
    }

}
