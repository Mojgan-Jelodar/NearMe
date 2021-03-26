//
//  UIView+Loading.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import UIKit
extension UIView {
    func lock() {
        if let _ = viewWithTag(10) {
            //View is already locked
        } else {
            let lockView = UIView()
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
            lockView.tag = 10
            lockView.alpha = 0.0
            addSubview(lockView)
            lockView.center = superview!.center
            let activity = UIActivityIndicatorView(style: .white)
            activity.hidesWhenStopped = true
            lockView.addSubview(activity)
            activity.center = lockView.center
            activity.startAnimating()
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }

    func unlock() {
        if let lockView = viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { _ in
                lockView.removeFromSuperview()
            }
        }
    }
}
