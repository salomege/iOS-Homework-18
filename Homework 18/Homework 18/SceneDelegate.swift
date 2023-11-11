//
//  SceneDelegate.swift
//  Homework 18
//
//  Created by salome on 11.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        //
        guard let someScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: someScene)
        let firstVC = MoviesListViewController()
        window?.rootViewController = firstVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
 
    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
   
    }

}

