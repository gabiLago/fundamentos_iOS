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
    
    let houses = Repository.local.houses
    let seasons = Repository.local.seasons
    var houseDetailViewController: HouseDetailViewController!
    var seasonDetailViewController: SeasonDetailViewController!
    var lastHouseSelected: House!
    var seasonListViewController: SeasonListViewController!
    var houseListViewController: HouseListViewController!
    let splitViewController = UISplitViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        
        // Recuperar la última casa seleccionada (si hay alguna)
        lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        
        // TabBar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            seasonListViewController.wrappedInNavigation()
        ]
        
        // Delegates
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarController.delegate = self
        
        // SplitView
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailViewController.wrappedInNavigation()
        ]
        
        window?.rootViewController = splitViewController
        
        return true
    }
    
    //UITabBarControllerDelegate implementation
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
        
        if(viewController.title! == "Seasons") {
            splitViewController.showDetailViewController(seasonDetailViewController.wrappedInNavigation(), sender: nil)
        } else {
            splitViewController.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: nil)
        }
        
    }
}
