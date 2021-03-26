//
//  AroundMeInteractor.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
protocol I2PAroundMeProtocol: class {
    func fetched(items : [Items])
    func fetched(error: Error)
}
protocol P2IAroundMeProtocol: class {
    var output : I2PAroundMeProtocol? { get set }
    func explore(lat: Double,long : Double)
}


final class AroundMeInteractor: P2IAroundMeProtocol {
    weak internal var output: I2PAroundMeProtocol?
    required init(delegate : I2PAroundMeProtocol ){
        self.output = delegate
    }
    private lazy var dataProviders : [DataProvider] = {
        return [ServiceDataProvider(delegate: self),
                CacheDataProvider(delegate: self)]
    }()
    
    func explore(lat: Double, long: Double) {
        if Connectivity.isConnectedToInternet() {
            dataProviders[0].fetch(lat: lat, long: long)
        } else {
            dataProviders[1].fetch(lat: lat, long: long)
        }
    }
}

extension AroundMeInteractor : DataProviderDelegate {
    func fetched(items: [Items]) {
        self.output?.fetched(items: items)
    }
    
    func failedFetchBy(error: Error) {
        self.output?.fetched(error: error)
    }
    
    
}