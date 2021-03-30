//
//  TipCell.swift
//  Balad
//
//  Created by mozhgan on 3/29/21.
//

import UIKit

final class TipCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblDislikeCount: UILabel!

}
extension TipCell {
    func configCell(tip: Comment) {
        lblUsername.text = "\(tip.user?.firstName ?? "" )" + "\(tip.user?.lastName ?? "" )"
        lblComment.text = tip.text
        lblLikeCount.text = "\(tip.agreeCount)"
        lblDislikeCount.text = "\(tip.disagreeCount)"
    }
}
