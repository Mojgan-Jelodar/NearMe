//
//  PhotoViewCell.swift
//  Balad
//
//  Created by mozhgan on 3/29/21.
//

import UIKit
import Kingfisher
enum PhotoQulities {
    case original
    case size(width: Float, height: Float)

    func value() -> String {
        switch self {
        case .original:
            return "original"
        case .size(let width, let height):
            return "\(width)x\(height)"
        }
    }
}

final class PhotoViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var downloadProgerssBar: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(photo: Photo) {
        KF.url(URL(string: (photo.prefix ?? "") +  PhotoQulities.original.value() + (photo.suffix ?? "") ))
            .loadDiskFileSynchronously()
            .diskCacheExpiration(StorageExpiration.days(3))
            .fade(duration: 0.25).onSuccess({ (_) in
                self.downloadProgerssBar.isHidden = true
            }).onFailure({ (error) in
                print("Download Failed by Error ::\(error)")
            }).onProgress({ [weak self](receivedSize, totalSize) in
                guard let strongSelf = self else { return }
                strongSelf.downloadProgerssBar.progress = Float(receivedSize / totalSize)
            }).set(to: imgView)
    }

}
