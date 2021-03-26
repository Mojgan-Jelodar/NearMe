//
//  UIView+Nibloadable.swift
//  Balad
//
//  Created by mozhgan on 3/27/21.
//

import UIKit

// MARK: Protocol Definition

/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: class {
  /// The nib file to use to load a new instance of the View designed in a XIB
  static var nibFile: UINib { get }
}

// MARK: Default implementation

public extension NibLoadable {
  /// By default, use the nib which have the same name as the name of the class,
  /// and located in the bundle of that class
  static var nibFile: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

// MARK: Support for instantiation from NIB

public extension NibLoadable where Self: UIView {
  /**
   Returns a `UIView` object instantiated from nib

   - returns: A `NibLoadable`, `UIView` instance
   */
  static func loadFromNib() -> Self {
    guard let view = nibFile.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("The nib \(nibFile) expected its root view to be of type \(self)")
    }
    return view
  }
}
//extension UIView {
//    class var nibName: String {
//
//        let name = "\(self)".components(separatedBy: ".").first ?? ""
//        return name
//    }
//
//    class var nib: UINib? {
//        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
//            return UINib(nibName: nibName, bundle: nil)
//        } else {
//            return nil
//        }
//    }
//
//    class func fromNib(nibNameOrNil: String? = nil) -> Self {
//        return fromNib(nibNameOrNil: nibNameOrNil, type: self)
//    }
//
//    class func fromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
//        let v: T? = fromNib(nibNameOrNil: nibNameOrNil, type: T.self)
//        return v!
//    }
//
//    class func fromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
//        var view: T?
//        let name: String
//        if let nibName = nibNameOrNil {
//            name = nibName
//        } else {
//            // Most nibs are demangled by practice, if not, just declare string explicitly
//            name = nibName
//        }
//        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
//        for v in nibViews! {
//            if let tog = v as? T {
//                view = tog
//            }
//        }
//        return view
//    }
//}
