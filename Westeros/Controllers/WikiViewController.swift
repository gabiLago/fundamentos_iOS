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
    
    // MARK: Properties
    let model: House
    
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
        syncModelWithView()
    }
    
    func syncModelWithView() {
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
}
