//
//  AppDelegate.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        // Creamos los modelos
        let houses = Repository.local.houses
        
      
        // Crear el combinador
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = houses.map { HouseDetailViewController(model: $0).wrappedInNavigation() }
        
        
        // Asignamos el rootViewController del window
        window?.rootViewController = tabBarController
        
        return true
    }


}

