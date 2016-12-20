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
    
    // MARK: Delegates, Data Source functions
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

        return cell
    }

    // MARK: Serialization data function
    
    func parseJson(data: Data, completionHandler: @escaping ([Articles]?) -> ()) {
        var newArticles : [Articles] = []
        if let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] {
            
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
    
    // MARK: This function fetch the data
    func fetchData(closure: @escaping ([Articles]?)->()){

        let urlString = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=066d82458ed84eeeac28a86095ec88b9"
        let urlRequest = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: urlRequest) { rawData, response, error in

            guard let respnseData = rawData else {
                closure(nil)
                return
            }
            
            self.parseJson(data: respnseData, completionHandler: closure)
        }
        task.resume()
    }
}

