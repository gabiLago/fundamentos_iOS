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
        let starkSigilImage = UIImage(named: "codeIsComing")!
        let starkSigil = Sigil(image: starkSigilImage, description: "Lobo Huargo")
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming")
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        // Creamos los controladores
        let starkViewController = HouseDetailViewController(model: starkHouse)
        let lannisterViewController = HouseDetailViewController(model: lannisterHouse)
        
        // Crear el combinador
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            starkViewController.wrappedInNavigation(),
            lannisterViewController.wrappedInNavigation()
        ]
        
        // Asignamos el rootViewController del window
        window?.rootViewController = tabBarController
        
        return true
    }


}

