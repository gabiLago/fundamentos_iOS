//
//  AppDelegate.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 07/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var houseDetailViewController: HouseDetailViewController!
    var houseListViewController: HouseListViewController!
    var lastHouseSelected: House!
    
    var seasonDetailViewController: SeasonDetailViewController!
    var seasonListViewController: SeasonListViewController!
    var lastSeasonSelected: Season!
    
    let splitViewController = UISplitViewController()
    let tabBarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Houses Controllers
        let houses = Repository.local.houses
        houseListViewController = HouseListViewController(model: houses)
        lastHouseSelected = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        houseListViewController.delegate = houseDetailViewController
        
        // Seasons Controllers
        let seasons = Repository.local.seasons
        seasonListViewController = SeasonListViewController(model: seasons)
        lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        seasonListViewController.delegate = seasonDetailViewController
        
        // TabBar
        tabBarController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            seasonListViewController.wrappedInNavigation()
        ]
        tabBarController.delegate = self
        
        // SplitView
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailViewController.wrappedInNavigation()
        ]
        splitViewController.preferredDisplayMode = .allVisible
        
        window?.rootViewController = splitViewController
        return true
    }
}

extension AppDelegate:  UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if (!splitViewController.isCollapsed){
            
            if(viewController.title! == "Seasons") {
                splitViewController.showDetailViewController(seasonDetailViewController.wrappedInNavigation(), sender: nil)
            } else {
                splitViewController.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: nil)
            }
        }
    }
}
