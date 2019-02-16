//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 16/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var episodeSynopsis: UILabel!
    @IBOutlet weak var episodeScreeningDate: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    
    // MARK: Properties
    var model: Episode
    
    // MARK: Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
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

        episodeSynopsis.text = model.synopsis
        episodeScreeningDate.text = "Fecha de estreno: \(dateToString(model.screeningDate))"
        episodeSeason.text = String(model.season.name)
    }
}
