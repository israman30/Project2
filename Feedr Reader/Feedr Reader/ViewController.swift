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
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.reloadData()
        
        
        fetchData(closure: {arrayArticles in
            self.articlesJson = arrayArticles!
            self.dataTableView.reloadData()
        })
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesJson.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! NewsTableViewCell
        cell.authorLabel.text = articlesJson[indexPath.row].author
        cell.descriptionLabel.text = articlesJson[indexPath.row].description
        cell.newsLabel.text = articlesJson[indexPath.row].title
        let thisArticle = articlesJson[indexPath.row]
        cell.updateCell(cellData: thisArticle)
//        URLSession.shared.dataTask(with: articlesJson[indexPath.row].imageURL, completionHandler: { rawData, response, error in
//            cell.newsImage.image = UIImage(data: rawData)
//        })
        return cell
    }

    
    
    func parseJson(data: Data, completionHandler: @escaping ([Articles]?) -> ()) {
        var newArticles : [Articles] = []
        if let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] {
//            myArticles = Articles(data: jsonObject)
            
            let realArticlesJson = jsonObject["articles"] as! [[String : Any]]
            for newArticle in realArticlesJson {
                let articles = Articles(data: newArticle)
                newArticles.append(articles)
            }
            DispatchQueue.main.async {
                completionHandler(newArticles)
            }
        }
    }
    
    
    
    
    func fetchData(closure: @escaping ([Articles]?)->()){

        let urlString = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=066d82458ed84eeeac28a86095ec88b9"
        let urlRequest = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: urlRequest) { rawData, response, error in
//            if error != nil { print(error.debugDescription) }
//            else {
            guard let respnseData = rawData else {
                closure(nil)
                return
            }
//                
//                guard let rawData = rawData else { print("There is no data") ; return }
//               
//                    guard let data = try? JSONSerialization.jsonObject(with: rawData, options: .mutableContainers) as? [String : Any]
//                        
//                        else { print("There is no data") ; return  }
//    
//                    let dataJson = data?["articles"] as! [[String : Any]]
//                    for newArticles in dataJson {
//                        let articles = Articles(data: newArticles)
//                        self.articlesJson.append(articles)
            
            
            self.parseJson(data: respnseData, completionHandler: closure)
//                
//                
//               // Data need  to extracted step by step in the json serialization
//                
//                
//                }
//                
//                closure(self.articlesJson)
//                
//                DispatchQueue.main.async {
////                    self.spinner.stopAnimating()
//                }
//            }
        }
        task.resume()
//
//        
    }
}

