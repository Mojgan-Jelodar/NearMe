//
//  DetailRouter.swift
//  Balad
//
//  Created by mozhgan on 3/28/21.
//

import Foundation
import UIKit

protocol P2RDetailProtocol: class {
    static func createModule(item: Venue) -> UIViewController
}
final class DetailRouter: P2RDetailProtocol {
    static func createModule(item: Venue) -> UIViewController {
        let vc = DetailVC(item: item)
        let presenter = DetailPresenter()
        presenter.view = vc
        presenter.router = DetailRouter()
        presenter.interactor = DetailInteractor(delegate: presenter)
        vc.presenter = presenter
        return vc
    }
}
