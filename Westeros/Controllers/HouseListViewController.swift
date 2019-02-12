//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 07/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit


// Definimos nuestro propio delegado (que se definen siempre com un protocolo)

protocol HouseListViewControllerDelegate: class { //class se añade para que pueda ir con weak y evitar referencia circular
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate? // evitamos referencia circular con weak
    
    // MARK: Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la casa que lo ha pulsado
        let house = model[indexPath.row]
        
        // Avisamos al delegado
        // Quien quiera que se conforme al houseListViewController, para hacer lo que tenga que hacer
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Emitir la misma info por notificaciones (porque ya he usado un delegado para
        let notificationCenter = NotificationCenter.default        
        // Creamos la notificación
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house] )
        
        // Enviamos la notificación
        notificationCenter.post(notification)

        // Guardar la casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Descubrir cuál es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        let cellId = "HouseCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sync celda - modelo (view - model)
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell!
    }
    
   
}

extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int) {
        // UserDefaults - write
        // UserDefautls será nuestro motor de persistencia
        let userDefaults = UserDefaults.standard
        // Escribimos el indes en una key de nuestro motor de persistencia
        userDefaults.set(index, forKey: LAST_HOUSE_KEY)
        // Guardamos
        userDefaults.synchronize() // Por si acaso (save)
    }
    
    func lastSelectedHouse() -> House {
        // UserDefaults - read
        let userDefaults = UserDefaults.standard
        
        // Leemos de nuestro motor de persistencia
        let index = userDefaults.integer(forKey: LAST_HOUSE_KEY)
        
        // devolvemos la casa situada en el index
        return house(at: index)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
