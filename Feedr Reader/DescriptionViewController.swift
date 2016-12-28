//
//  DescriptionViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/9/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urlString: String!
    var urlGoogleString: String!
    var urlFoxString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: urlString)!))
        webView.loadRequest(URLRequest(url: URL(string: urlGoogleString)!))
        webView.loadRequest(URLRequest(url: URL(string: urlFoxString)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}
