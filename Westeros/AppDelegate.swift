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
        
        // models
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
      
        let houseListViewController = HouseListViewController(model: houses)
        
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        houseListViewController.delegate = houseDetailViewController
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        
        
        seasonListViewController.delegate = seasonDetailViewController
        
        let tabBarController = UITabBarController()
        
        
        tabBarController.viewControllers = [ seasonListViewController.wrappedInNavigation(), houseListViewController.wrappedInNavigation() ]
        
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailViewController.wrappedInNavigation()
        ]
        
        
        
        window?.rootViewController = tabBarController
        
        return true
    }


}

