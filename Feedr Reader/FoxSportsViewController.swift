//
//  FoxSportsViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/27/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit
import SafariServices

class FoxSportsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var foxArticles = [FoxArticles]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        requestAndReloadTableView()

    }
    
    func requestAndReloadTableView() {
        foxArticles = []
        self.tableView.reloadData()
        fetchData(with:.French, closure: {arrayArticles in
            self.foxArticles = arrayArticles!
            self.tableView.reloadData()
        })
    }

    func parseJson(data: Data, completionHandler: @escaping ([FoxArticles]?) -> ()) {
        var newArticles : [FoxArticles] = []
        if let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] {
            
            let realArticlesJson = jsonObject["articles"] as! [[String : Any]]
            for newArticle in realArticlesJson {
                let articles = FoxArticles(data: newArticle)
                newArticles.append(articles)
                
            }
            DispatchQueue.main.async {
                completionHandler(newArticles)
            }
        }
    }
    
    func fetchData(with language : Language, closure: @escaping ([FoxArticles]?)->()){
        
        let urlString = "https://newsapi.org/v1/articles?source=fox-sports&sortBy=top&apiKey=066d82458ed84eeeac28a86095ec88b9"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foxArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFox", for: indexPath) as! FoxSportsTableViewCell
        
        let displayFS = foxArticles[indexPath.row]
        
        cell.authorFoxLbl.text = displayFS.author
        cell.publishedFoxLbl.text = displayFS.publishedAt
        cell.descriptionFoxLbl.text = displayFS.description
        cell.titleFoxLbl.text = displayFS.title
        let foxPic = displayFS
        cell.updateCell(cellData: foxPic)
//        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safariVC = SFSafariViewController(url: URL(string: foxArticles[indexPath.row].url!)!)
        present(safariVC, animated: true, completion: nil)
    }
}
