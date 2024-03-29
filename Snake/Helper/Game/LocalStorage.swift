//
//  LocalStorage.swift
//  Snake
//
//  Created by Maxim Skorynin on 22.05.2021.
//

import Foundation

final class LocaleStorage {
    
    let userDefaults = UserDefaults()
    
    init() {
        userDefaults.register(defaults: ["isOnSound": true])
    }
    
    // MARK: - Public Properties
    
    var isOnSound: Bool {
        get {
            return userDefaults.bool(forKey: "isOnSound")
        } set {
            userDefaults.set(newValue, forKey: "isOnSound")
        }
    }
    
}

