//
//  AroundMePresenter.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
protocol V2PAroundMeProtocol: class {
    var view: P2VAroundMeProtocol? {get set}
    var interactor: P2IAroundMeProtocol? {get set}
    var router: P2RAroundMeProtocol? {get set}
    func fetch(lat: Double, long: Double)
    func showDetail(item: Items)
}
final class AroundMePresenter: V2PAroundMeProtocol {
    weak var view: P2VAroundMeProtocol?
    var interactor: P2IAroundMeProtocol?
    var router: P2RAroundMeProtocol?
    func fetch(lat: Double, long: Double) {
        view?.startLoading()
        interactor?.explore(lat: lat, long: long)
    }

    func showDetail(item: Items) {
        router?.showDetail(item: item)
    }
}

extension AroundMePresenter: I2PAroundMeProtocol {
    func fetched(items: [Items]) {
        view?.stopLoading()
        guard !items.isEmpty else {
            return
        }
        view?.show(items: items)
    }

    func fetched(error: Error) {
        view?.stopLoading()
        view?.show(error: error)
    }
}
