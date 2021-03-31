//
//  DetailCell.swift
//  Balad
//
//  Created by mozhgan on 3/31/21.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblChechInCount: UILabel!
    @IBOutlet weak var lblTipCount: UILabel!
    @IBOutlet weak var lblUserCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension DetailCell {
    func configCell(item: Venue) {
        lblName.text = item.name
        lblRating.text = "\(item.rating)"
        lblAddress.text = item.location?.formattedAddress.joined(separator: ",")
        lblDistance.text = "\(item.location?.distance ?? 0)"
        lblPhone.text = "\(item.contact?.formattedPhone ?? "-")"
        lblHours.text = "\(item.hours?.isOpen ?? false ? "is open" : "is closed" )"
        lblTipCount.text = "\(item.stats?.tipCount ?? 0)"
        lblChechInCount.text = "\(item.stats?.checkinsCount ?? 0)"
        lblUserCount.text = "\(item.stats?.usersCount ?? 0)"
    }
}
