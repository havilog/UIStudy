//
//  SceneDelegate.swift
//  UIStudy
//
//  Created by 한상진 on 2021/07/05.
//

import UIKit
import ChaiOnboarding
import CollectionView
import HVBottomSheet
import TodayHouse

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navi = UINavigationController(rootViewController: TodayHouseVC())
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
}

