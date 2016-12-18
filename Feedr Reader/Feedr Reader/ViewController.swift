//
//  ViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/6/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var articlesJson = [Articles]()
    
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        fetchData(closure: {rawData in
            self.articlesJson = rawData as [Articles]
        })
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesJson.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! NewsTableViewCell
            print(articlesJson)
        cell.authorLabel.text = articlesJson[indexPath.row].author
        cell.descriptionLabel.text = articlesJson[indexPath.row].description
        return cell
    }

    
    func fetchData(closure: @escaping ([Articles])->()){
        
        let urlString = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=066d82458ed84eeeac28a86095ec88b9"
        
        let urlRequest = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: urlRequest) { rawData, response, error in
            if error != nil { print(error.debugDescription) }
            else {
                
                guard let rawData = rawData else { print("There is no data") ; return }
                
                guard let data = try? JSONSerialization.jsonObject(with: rawData, options: .mutableContainers) as? [String : Any]
                    
                    else { print("There is no data") ; return  }
                
               // data need  to extracted step by step in the json serialization
                let dataJson = data?["articles"] as! [[String : Any]]
                
                var articlesJson: [Articles] = []
                
                for newArticles in dataJson {
                    let articles = Articles(data: newArticles)
                    articlesJson.append(articles)
                }
               
                DispatchQueue.main.async {
//                    self.spinner.stopAnimating()
                }
            }
        }
        task.resume()
        
        
    }
}

