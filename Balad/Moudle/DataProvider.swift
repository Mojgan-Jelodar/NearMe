//
//  DataProvider.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
protocol DataProviderDelegate: class {
    func fetched(items: [Items])
    func failedFetchBy(error: Error)
}
protocol DataProvider: class {
    var delegate: DataProviderDelegate? { get set}
    func fetch(lat: Double, long: Double)
}
