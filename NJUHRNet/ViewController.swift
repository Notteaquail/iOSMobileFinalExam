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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //startLoad()
        loadNet()
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
        let url = URL(string: "http://hr.nju.edu.cn")!//
        receivedData = Data()
        let task = session.dataTask(with: url)
        task.resume()
    }

    // delegate methods

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode),
            let mimeType = response.mimeType,
            mimeType == "text/html" else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.receivedData?.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            //self.loadButton.isEnabled = true
            if let error = error {
                print(error)
            } else if let receivedData = self.receivedData,
                let string = String(data: receivedData, encoding: .utf8) {
                self.webView.loadHTMLString(string, baseURL: task.currentRequest?.url)
            }
        }
    }
    
    

}

