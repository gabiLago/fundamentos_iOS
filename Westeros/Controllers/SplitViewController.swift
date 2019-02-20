//
//  SplitViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 20/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController {

    // Creamos el split view controller y asignamos lo
    splitViewController.viewControllers = [
    tabBarController,
    houseDetailViewController.wrappedInNavigation()
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
