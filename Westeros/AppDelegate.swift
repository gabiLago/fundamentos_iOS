//
//  AppDelegate.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 07/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate  {
    
    var window: UIWindow?
    var holi: String = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        // Crearnos los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Creamos los controladores (el que irá en master, y el que irá en el detail)
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        // Recuperar la última casa seleccionada (si hay alguna)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        
        // Crear UITabBarController
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            seasonListViewController.wrappedInNavigation()
        ]
        
        
        // Asigar delegados
        // Un objeto SOLO PUEDE TENER UN DELEGADO
        // Un objeto, puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarController.delegate = self
        
        // Creamos el split view controller y asignamos los controladores
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailViewController.wrappedInNavigation()
        ]
        
        

        // Asignamos el rootViewController del window
        window?.rootViewController = splitViewController
        
        
        return true
    }
  
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
        holi = ("Holi \(viewController.title!)")
    }

    
}
