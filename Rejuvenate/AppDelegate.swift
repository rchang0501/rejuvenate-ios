//
//  AppDelegate.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().tintColor = .rejuvenatePrimaryTint // changes the default appearance for all nav bars in the app
        UINavigationBar.appearance().backgroundColor = .rejuvenateNavigationBackground
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground() // set opaque colors for the nav bar (so when scrolling the elements won't overlap with the nav bar text
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance // if the scrolled content reaches the nav bar, UIKIt applies default appearnce settings
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

