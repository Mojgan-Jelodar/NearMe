//
//  AroundMeRouter.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
import UIKit
protocol P2RAroundMeProtocol: class {
    static func createModule() -> UIViewController
    func showDetail(item: Items)
}
final class AroundMeRouter : P2RAroundMeProtocol {
    weak var presentingVc : UIViewController?
    static func createModule() -> UIViewController {
        let vc =  AroundMeVC(nibName: "\(AroundMeVC.self)", bundle: nil)
        let presenter = AroundMePresenter()
        presenter.view = vc
        presenter.router = AroundMeRouter(presentingVc: vc)
        presenter.interactor = AroundMeInteractor(delegate: presenter)
        vc.presenter = presenter
        return vc
    }
    
    required init(presentingVc : UIViewController) {
        self.presentingVc = presentingVc
    }
    
    func showDetail(item: Items) {
        
    }
}
