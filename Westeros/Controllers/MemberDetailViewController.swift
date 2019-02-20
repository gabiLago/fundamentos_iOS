//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 19/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var alias: UILabel!
    @IBOutlet weak var house: UILabel!
    
    // MARK: Properties
    var model: Person
    
    // MARK: Initialization
    init (model: Person){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    // MARK: Sync
    func syncModelWithView() {
        fullName.text = "Nombre: \(model.fullName)"
        alias.text = "Alias: \(model.alias)"
        house.text = "Casa: \(String(model.house.name))"
    }
}
