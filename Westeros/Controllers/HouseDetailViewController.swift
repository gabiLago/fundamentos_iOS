//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 06/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class HouseDetailViewController:
    UIViewController {
   
    // MARK: Outlets
    @IBOutlet weak var HouseNameLabel: UILabel!
    @IBOutlet weak var SigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: Properties
    let model: House
    
    // MARK: Initializators
    init(model: House) {
        // Primero limpio mi mierda y luego llamo a super
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    // Chapuza de los de Curpertino relacionada con el miedo a nil
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
        
        HouseNameLabel.text = "House \(model.name)"
        SigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
}
