//
//  SceneDelegate.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/27/22.
//

import UIKit
import Reusable

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        configureLoginViewController()
    }

    func configureLoginViewController() {
        let viewModel = PhotoListViewModel()
        let storyboard = UIStoryboard(name: "PhotoList", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = PhotoListViewController.instantiate(with: viewModel)
        navigationController.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
    }
    
}
