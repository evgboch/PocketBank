//
//  AboutUsViewController.swift
//  PocketBank
//
//  Created by Евгений on 16.11.16.
//  Copyright © 2016 BocharInc. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var infoPage: UIWebView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let site = URL(string: "http://www.sberbank.ru/ru/about/today") {
        let urlReq = URLRequest(url: site)
        infoPage.loadRequest(urlReq)
            
        }
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        infoPage.goBack()
    }
    
    @IBAction func reloadButtonTap(_ sender: Any) {
        infoPage.reload()
    }
    
    @IBAction func forwardButtonTap(_ sender: Any) {
        infoPage.goForward()
    }
}
