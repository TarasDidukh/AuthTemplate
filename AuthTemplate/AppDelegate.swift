//
//  AppDelegate.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/25/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import UIKit
import SwinjectStoryboard
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container: Container = {
        let container = Container()
        container.storyboardInitCompleted(SigninController.self) { r, c in
            c.profileService = r.resolve(ProfileServicing.self)
            c.authService = r.resolve(AuthServicing.self)
        }
        container.storyboardInitCompleted(ProfileController.self){ r, c in
            c.authService = r.resolve(AuthServicing.self)
        }
        container.register(Networking.self) { _ in Network() }
        container.register(StorageRepositoring.self) { _ in RealmRepository() }
        container.register(ProfileServicing.self) { r in
            ProfileService(network: r.resolve(Networking.self)!, storage: r.resolve(StorageRepositoring.self)!)
        }
        
        container.register(AuthServicing.self) { r in
            AuthService(storage: r.resolve(StorageRepositoring.self)!)
        }
        
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        var vc: UIViewController?
        if let user = container.resolve(AuthServicing.self)!.checkAuthentication()  {
                vc = storyboard.instantiateViewController(withIdentifier: "ProfileController")
                (vc as! ProfileController).user = user
        } else {
            vc = storyboard.instantiateViewController(withIdentifier: "SigninController")
        }
        let navigationController = UINavigationController(rootViewController: vc!)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

