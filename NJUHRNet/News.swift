//
//  News.swift
//  NJUHRNet
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation

class News {
    var title: String
    var netURL: String
    var date: String
    var clickCount: Int
    
    init(title: String, netURL: String, date: String, clickCount: Int) {
        self.title = title
        self.netURL = netURL
        self.date = date
        self.clickCount = clickCount
    }
}
