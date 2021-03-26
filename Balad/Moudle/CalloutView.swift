//
//  CalloutView.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import UIKit
protocol  CalloutViewDelegate: class {
    func showDetail(item: Items)
}

final class CalloutView: UIView, NibLoadable {

    weak var delegate: CalloutViewDelegate?
    var item: Items? {
        didSet {
            lblName?.text = item?.venue?.name
            lblAddress?.text = item?.venue?.location?.address
        }
    }
    @IBOutlet weak var lblName: UILabel?
    @IBOutlet weak var lblAddress: UILabel?

    @IBAction func showDetail(sender: UIButton) {
        self.delegate?.showDetail(item: item!)
    }
}
