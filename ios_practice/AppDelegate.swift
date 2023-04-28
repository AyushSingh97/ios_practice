//  AppDelegate.swift
//  MyApp
//
//  Created by Ayush Singh on 28/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// Navigation bar appearance for the app
    var navigationBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
    
    /// Orientation mask for restricting the screen rotation
    var restrictRotation: UIInterfaceOrientationMask = .portrait
    
    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppBarAppearance()
        return true
    }
    
    /**
     Sets up the appearance of the app's navigation bar.
     - Returns: Void
     */
    func setAppBarAppearance() {
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = Constants.Colors.accentColor
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    // MARK: UISceneSession Lifecycle
    
    /// Tells the delegate the app's configuration for the specified scene.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    /// Tells the delegate that the app is no longer using a given scene.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    /**
     Returns the supported interface orientations for the app's window.
     - Returns: A UIInterfaceOrientationMask specifying the supported orientations.
     */
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.restrictRotation
    }
}
