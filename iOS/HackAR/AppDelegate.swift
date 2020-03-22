//
//  AppDelegate.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import UIKit
import NMAKit

let credentials = (
    appId: "uivV5oUmnUPS1ekRCSf8",
    appCode: "njeHOmEf1GtDnWd3Nz85mQ",
    licenseKey: "T9fo/A7kv2VMvrBGa/FqxMDVz5jkl9fQEWTt8EaDVTddpySV/plECa5L42TfpFT/R/g3MfcJOvUkcgl6T1VK4lxjqN7OYFLxO9Pd+5w09LG2DYzH77QgWBnm8cyMnh3LgLTgu57hl8k9WSJsT9hQS6mMU+bzK7TxOKgopj7u11iegeJvDC3MqiJMA8wr1i7fV33MyEWdc+qPMToTyjsvZZCqWHudZFgB2MRvlFeOoftODjEQAc/CSmxpSTZpmmPKYRsOCdUetfCaycVFddF1Y4hQaqF113A2AcuS7dwpcUglWuOU4CSpLxvjQXbZQApHMMOCZLTRwe+/nVgrU4T+K3RzVsRlwT6Ayn//liSwPh+A6CGcuwvDp5lJXmAAN4lv3iTp0PNOo55Ty0KMondk9MpYQ2o+dZJanTTv/qfHNtPk9e2Iw+BYd8301QU/y9katEQuD4sVdj38jQj2vIzqzEPbxktKjJ5hrpolgSlsZJnFnLI/XT+7NQi5ZYROsdeD6SyQ1nl4f8WjYsjh6vTckK8nzFwateaXKF43Up4bgdyDHG35R8zG5qZ7XPWPAbFPWWDNY7PxzLSsgSArQXnDKOIKSX38S/LxFcxT0BlssSPOIzM1F4ieh8mn/gXOH8bRnpd/IDp+jTiaL9fwdXHb68cmAj1SYXavaCxrJfwQHyo="
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NMAApplicationContext.setAppId(credentials.appId,
                                       appCode: credentials.appCode,
                                       licenseKey: credentials.licenseKey)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = buildFriends()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func buidMap() -> UIViewController {
        let vc = MapViewController()
        let presenter = MapPresenter()
        presenter.view = vc
        vc.output = presenter
        return UINavigationController(rootViewController: vc)
    }
    
    private func buildFriends() -> UIViewController {
        let vc = FriendsListViewController()
        let presenter = FriendsListPresenter()
        presenter.view = vc
        vc.output = presenter
        return UINavigationController(rootViewController: vc)
    }
    
    private func buildAR() -> UIViewController {
        let rootVc = ARViewController()
        let presenter = ARPresenter()
        presenter.view = rootVc
        rootVc.output = presenter
        return rootVc
    }
}

