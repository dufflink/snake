//
//  AppDelegate.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = SoundHelper.shared
        
        return true
    }

}

