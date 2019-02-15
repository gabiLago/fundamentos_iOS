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
        let seasons = Repository.local.seasons
       
        
        // Creamos los controladores (el que irá en master y el que irá en detail)
        let houseListViewController = HouseListViewController(model: houses)
      
        
        // recuperar la última casa seleccionada (si la hay)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        // Asignar delegados
        // UN OBJETO SOLO PUEDE TENER UN DELEGADO
        // UN OBJETO PUEDE SER DELAGOD DE MUCHOS OTROS OBJETOS
        houseListViewController.delegate = houseDetailViewController
        // Asignar otro delegado para iphone
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            houseDetailViewController.wrappedInNavigation()
        ]
        
     
        
        // Asignamos el rootViewController del window
        window?.rootViewController = splitViewController
        
        return true
    }


}

