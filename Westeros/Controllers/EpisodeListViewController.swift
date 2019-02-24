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
    
    var model: [Episode]
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta de las notificaciones
        // Tan pronto como te des de alta, implementa el código para darte de baja. Si no te olvidrás
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(SEASON_DID_CHANGE_NOTIFICATION)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(seasonDidChange(notification:)),
                                       name: name,
                                       object: nil) // Object es quien manda la notificación
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
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
    
    // MARK: Notification
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        guard let season = info[SEASON_KEY] as? Season else {
            return
        }
        
        self.model = season.sortedEpisodes
        
        
        // I don´t understand the backBarButtonItem behaviour
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back Button", style: .plain, target: nil, action: nil)
        
        // Reload tableView
        tableView.reloadData()
        
    }
    
}



extension EpisodeListViewController: UITableViewDelegate { }


