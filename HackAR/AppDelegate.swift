//
//  AppDelegate.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVc = ARViewController()
        let presenter = ARPresenter()
        presenter.view = rootVc
        rootVc.output = presenter
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        return true
    }
}

