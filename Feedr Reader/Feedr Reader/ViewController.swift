//
//  ViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/6/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = URL(string:"https://newsapi.org/v1/articles?source=techcrunch&apiKey=066d82458ed84eeeac28a86095ec88b9")!
//        let json = URLSession.shared.dataTask(with: url){data, response, error in guard let data = data, error == nil else{return}
//            DispatchQueue.main.sync() {
//    
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        return cell    }

}

