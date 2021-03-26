//
//  String+Localizable.swift
//  Balad
//
//  Created by mozhgan on 3/26/21.
//

import Foundation
public extension String {

    ///
    /// Localize the current string to the selected language
    ///
    /// - returns: The localized string
    ///
    func localiz(comment: String = "") -> String {
        guard let bundle = Bundle.main.path(forResource: NSLocale.preferredLanguages.first, ofType: "lproj") else {
            return NSLocalizedString(self, comment: comment)
        }

        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
    }

}
