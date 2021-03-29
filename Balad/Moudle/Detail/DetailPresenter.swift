//
//  DetailPresenter.swift
//  Balad
//
//  Created by mozhgan on 3/29/21.
//

import Foundation
protocol V2PDetailProtocol: class {
    var view: P2VDetailProtocol? {get set}
    var interactor: P2IDetailProtocol? {get set}
    var router: P2RDetailProtocol? {get set}
    func show(items: Items)
}
final class DetailPresenter: V2PDetailProtocol {
    weak var view: P2VDetailProtocol?
    var interactor: P2IDetailProtocol?
    var router: P2RDetailProtocol?

    func show(items: Items) {
        view?.show(items: items)
        interactor?.photo(id: items.venue?.id ?? "")
    }
}

extension DetailPresenter: I2PDetailProtocol {
    func fetched(error: Error) {
        view?.show(error: error)
    }

    func fetched(photos: Photos) {
        view?.show(photos: photos)
    }
}
