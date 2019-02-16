//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 16/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let model: [Episode]
    
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self       
    }
    
}

extension EpisodeListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = model[indexPath.row]
        let cellId = "EpisodeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = episode.title
               
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // What episode was clicked?
        let episode = model[indexPath.row]
        
        // Build detail controller for episode
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        // Go to episode
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
        
    }
    
}



extension EpisodeListViewController: UITableViewDelegate { }


