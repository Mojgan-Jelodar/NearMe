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
    var photos: [Photo] { get set }
    var tips: [Comment] { get set}
    func show(item: Venue)
}
final class DetailPresenter: V2PDetailProtocol {
    var photos: [Photo] = [] {
        didSet {
            self.view?.show(photos: photos)
        }
    }
    var tips: [Comment] = [] {
        didSet {
            self.view?.show(tips: tips)
        }
    }
    weak var view: P2VDetailProtocol?
    var interactor: P2IDetailProtocol?
    var router: P2RDetailProtocol?

    func show(item: Venue) {
        view?.show(item: item)
        interactor?.photos(id: item.id)
        interactor?.tips(id: item.id)
    }
}

extension DetailPresenter: I2PDetailProtocol {
    func fetched(error: Error) {
        self.view?.show(error: error)
    }

    func fetched(photos: [Photo]) {
        self.photos = photos
    }

    func fetched(tips: [Comment]) {
        self.tips = tips
    }
}
