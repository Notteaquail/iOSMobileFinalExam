//
//  ViewController.swift
//  NJUHRNet
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, URLSessionDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startLoad()
        //loadNet()
    }

    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
    var receivedData: Data?

    func startLoad() {
        //loadButton.isEnabled = false
        let url = URL(string: self.url!)!//
        webView.load(URLRequest(url: url))
    }

    
    
    

}

