//
//  DescriptionGoogleViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/26/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class DescriptionGoogleViewController: UIViewController {

    @IBOutlet weak var googleWebView: UIWebView!
    
    var urlGoogleString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleWebView.loadRequest(URLRequest(url: URL(string: urlGoogleString)!))

        
    }

}
