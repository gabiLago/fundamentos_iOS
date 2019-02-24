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
    var model: Season
    
    // MARK: Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
            }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    

    
    // MARK: Sync
    func syncModelWithView() {
        seasonName.text = model.name
        seasonReleaseDate.text = "Fecha de estreno: \(dateToString (model.releaseDate))"
        numberOfEpisodes.text = "Número de episodios: \(String(model.count))"
        title = model.name
    }
    
    // MARK: UI
    func setupUI() {
        //UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        // Mostrar los botones
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    @objc func displayEpisodes() {
        
        // Creamos el controlador
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Lo mostramos mediante push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        // Re-asigna el modelo
        self.model = season
        
        // Sincroniza modelo (el nuevo) con la vista
        syncModelWithView()
    }
}
