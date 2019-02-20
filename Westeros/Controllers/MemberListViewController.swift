//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 08/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties
    var model: [Person]
    
    // MARK: Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Houses did Change Notification
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self, selector: #selector(houseDidChange(notification:)), name: name, object: nil)
    }
    
    // Remove Notifcations
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: Notification
    @objc func houseDidChange(notification: Notification) {
        
        guard let info = notification.userInfo else {
            return
        }
        
        
        guard let house = info[HOUSE_KEY] as? House else {
            return
        }
        
        // Update the model with new call to sortedMembers with the new house
        model = house.sortedMembers
        
        // Reload tableView
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // What episode was clicked?
        let member = model[indexPath.row]
        
        // Build detail controller for episode
        let memberDetailViewController = MemberDetailViewController(model: member)
        
        // Go to episode
        navigationController?.pushViewController(memberDetailViewController, animated: true)
        
    }
    
}

extension MemberListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Descubrir la persona que
        let person = model[indexPath.row]
        
        // Pedir una celda a la tabal, si es que la tiene, o si no crearla
        let cellId = "MemberCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sync modelo - vista
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        // Devolver la persona
        return cell!
    }
    
}

extension MemberListViewController: UITableViewDelegate { }
