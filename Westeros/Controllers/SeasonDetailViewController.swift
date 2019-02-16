//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 16/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var seasonName: UILabel!
    @IBOutlet weak var seasonReleaseDate: UILabel!
    @IBOutlet weak var numberOfEpisodes: UILabel!
    
    // MARK: Properties
    let model: Season
    
    // MARK: Initialization
    init(model: Season) {
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yy"
        
        seasonName.text = model.name
        seasonReleaseDate.text = "Fecha de estreno: \(dateToString (model.releaseDate))"
        numberOfEpisodes.text = "Número de episodios: \(String(model.count))"
    }
}
