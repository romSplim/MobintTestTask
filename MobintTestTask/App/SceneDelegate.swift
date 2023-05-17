//
//  SceneDelegate.swift
//  MobintTestTask
//
//  Created by ramil on 09.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let builder = ModuleBuilder()
        let listCompaniesView = builder.buildListCompaniesModule()
        window = UIWindow(windowScene: scene)
        window?.rootViewController = listCompaniesView
        window?.makeKeyAndVisible()
    }
}

