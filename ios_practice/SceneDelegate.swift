// SceneDelegate.swift
//
// Created by Ayush Singh
//

import UIKit

/// The SceneDelegate class conforms to the UIWindowSceneDelegate protocol and is responsible for managing the app's windows.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    /**
     Called when the app is about to connect to a scene.
     - Parameters:
        - scene: The scene that is about to connect.
        - session: The session associated with the connecting scene.
        - connectionOptions: Options for connecting to the scene.
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    /**
     Called when the scene is disconnected.
     - Parameter scene: The disconnected scene.
     */
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    /**
     Called when the scene becomes active.
     - Parameter scene: The active scene.
     */
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    /**
     Called when the scene will resign active.
     - Parameter scene: The scene that will resign active.
     */
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    /**
     Called when the scene will enter the foreground.
     - Parameter scene: The scene that will enter the foreground.
     */
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    /**
     Called when the scene enters the background.
     - Parameter scene: The scene that entered the background.
     */
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
