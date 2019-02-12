//
//  WikiViewController.swift
//  Westeros
//
//  Created by Gabriel Lago Blasco on 07/02/2019.
//  Copyright © 2019 Gabi Lago Blasco. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Properties
    var model: House
    
    // MARK: Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta de las notificaciones
        // Tan pronto como te des de alta, implementa el código para darte de baja. Si no te olvidrás
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange(notification:)),
                                       name: name,
                                       object: nil) // Object es quien manda la notificación
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func syncModelWithView() {
        // Mostramos el loadingView y lo animamos
        spinner.isHidden = false
        spinner.startAnimating()
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
    
    // MARK: Notification
    @objc func houseDidChange(notification: Notification) {
        // Sacar el userInfo
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        guard let house = info[HOUSE_KEY] as? House else {
            return
        }
        
        // Actualizar mi modelo
        model = house
        
        // Sincronizar modelo y vista
        syncModelWithView()
        
    }
}

// Delegados
// Should: para pedir permiso
// Will: Oye, que sepas que estoy apunto de hacer algo
// Did: hey, que sepas que ya lo he hecho

extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Detener la animación del activityIndicator
        spinner.stopAnimating()
        // Ocultarlo
        spinner.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated,  .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}

