//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 16/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let season = model[indexPath.row]
        
        let cellId = "SeasonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = season.name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // What season has been clicked?
        let season = model[indexPath.row]
        
        guard let splitView = self.splitViewController else {
            return
        }
        
        if (splitView.isCollapsed) {
            navigationController?.pushViewController(SeasonDetailViewController(model: season), animated: true)
        } else {
            delegate?.seasonListViewController(self, didSelectSeason: season)
        }
        // Notification with the same info
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION), object: self, userInfo: [SEASON_KEY: season])
        
        notificationCenter.post(notification)
        
        saveLastSelectedSeason(at: indexPath.row)
    }
    
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at index: Int) {
        // UserDefaults será nuestro motor de persistencia
        let userDefaults = UserDefaults.standard
        
        // Escribimos el index en una key de nuestro motor de persistencia
        userDefaults.set(index, forKey: LAST_SEASON_KEY)
        
        // Guardamos
        userDefaults.synchronize() // Por si acaso (save)
    }
    
    func lastSelectedSeason() -> Season {
        // UserDefaults
        let userDefaults = UserDefaults.standard
        
        // Leemos de nuestro motor de persistencia
        let index = userDefaults.integer(forKey: LAST_SEASON_KEY) // 0 es default
        
        // Devolvemos la casa situada en el index
        return season(at: index)
    }
    
    func season(at index: Int) -> Season {
        return model[index]
    }
}
