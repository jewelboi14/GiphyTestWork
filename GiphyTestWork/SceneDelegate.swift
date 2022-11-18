//
//  SceneDelegate.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainScreenViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

}

