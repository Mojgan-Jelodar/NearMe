//
//  DetachableObject.swift
//  Balad
//
//  Created by mozhgan on 3/27/21.
//

import Realm
import RealmSwift
protocol DetachableObject: AnyObject & Storable {
  func detached() -> Self
}

extension Object: DetachableObject {
  func detached() -> Self {
    let detached = type(of: self).init()
    for property in objectSchema.properties {
      guard let value = value(forKey: property.name) else {
        continue
      }
      if let detachable = value as? DetachableObject {
        detached.setValue(detachable.detached(), forKey: property.name)
      } else { // Then it is a primitive
        detached.setValue(value, forKey: property.name)
      }
    }
    return detached
  }
}

extension List: DetachableObject {
  func detached() -> List<Element> {
    let result = List<Element>()
    forEach {
      if let detachableObject = $0 as? DetachableObject,
        let element = detachableObject.detached() as? Element {
        result.append(element)
      } else { // Then it is a primitive
        result.append($0)
      }
    }
    return result
  }
}

extension Realm {
    func writeAsync<T: ThreadConfined>(obj: T, errorHandler: @escaping ((_ error: Swift.Error) -> Void) = { _ in return }, block: @escaping ((Realm, T?) -> Void)) {

        let wrappedObj = ThreadSafeReference(to: obj)
        let backgroundQueue = DispatchQueue(label: ".realm")
        let config = self.configuration
        backgroundQueue.async {
            autoreleasepool {
                do {

                    let realm = try Realm(configuration: config)
                    guard let obj = realm.resolve(wrappedObj), obj.isInvalidated == false else { return }
                    try realm.write {
                        block(realm, obj)
                    }
                } catch {
                    errorHandler(error)
                }
            }
        }
    }

}
