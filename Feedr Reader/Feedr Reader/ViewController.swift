//
//  ViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/6/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit
import SafariServices

enum Language : String {
    case English = "en"
    case German = "de"
    case French = "fr"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var articlesJson = [Articles]()
    
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        requestAndReloadTableView()
    }
    
    func requestAndReloadTableView() {
        articlesJson = []
        self.dataTableView.reloadData()
        fetchData(with:.French, closure: {arrayArticles in
            self.articlesJson = arrayArticles!
            self.dataTableView.reloadData()
        })
    }
    
//    @IBAction func topLeftButtonTouchUpInside(_ sender: Any) {
//        requestAndReloadTableView()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Delegates, Data Source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! NewsTableViewCell
        
        let displayTC = articlesJson[indexPath.row]
        
        cell.authorLabel.text = displayTC.author
        cell.descriptionLabel.text = displayTC.description
        cell.newsLabel.text = displayTC.title
        cell.newsPublishLabel.text = displayTC.publishedAt
        let thisArticle = displayTC
        cell.updateCell(cellData: thisArticle)
//        cell.backgroundColor = UIColor.lightGray

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
    func fetchData(with language : Language, closure: @escaping ([Articles]?)->()){

        let urlString = "https://newsapi.org/v1/articles?source=techcrunch&language=\(language.rawValue)&apiKey=066d82458ed84eeeac28a86095ec88b9"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safariVC = SFSafariViewController(url: URL(string: articlesJson[indexPath.row].url!)!)
        present(safariVC, animated: true, completion: nil)
        
    }
}

