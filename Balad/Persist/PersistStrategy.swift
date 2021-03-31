//
//  File.swift
//  Balad
//
//  Created by mozhgan on 3/27/21.
//

import Foundation
import RealmSwift
protocol PersistStrategy {
    mutating func save<T: Storable>(objects: [T]) throws
    mutating func retrive<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void))
}
struct FilePersist: PersistStrategy {
    mutating func save<T>(objects: [T]) throws where T: Storable {

    }

    func retrive<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> Void)) {

    }

}

struct DbPersist: PersistStrategy {
    private var configuration: ConfigurationType
    private lazy var realmStorageContext: RealmStorageContext? = {
        do {
            return try RealmStorageContext(configuration: configuration)
        } catch let error {
            print("Access to database : \(error.localizedDescription)")
            return nil
        }
    }()

    init(configuration: ConfigurationType = .basic(url: nil)) {
        self.configuration = configuration
    }

    mutating func save<T>(objects: [T]) throws where T: Storable {
        try realmStorageContext?.save(objects: objects)
    }

    mutating func retrive<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> Void)) {
        realmStorageContext?.fetch(model, predicate: predicate, sorted: sorted, completion: { (objects) in
            completion(objects)
        })
    }
}

struct ContextPersist: PersistStrategy {

    private var strategy: PersistStrategy

    /// Usually, the Context accepts a strategy through the constructor, but
    /// also provides a setter to change it at runtime.
    init(strategy: PersistStrategy) {
        self.strategy = strategy
    }

    mutating func save<T>(objects: [T]) throws where T: Storable {
        try self.strategy.save(objects: objects)
    }

    mutating func retrive<T>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> Void)) where T: Storable {
        self.strategy.retrive(model, predicate: predicate, sorted: sorted, completion: completion)
    }
}
