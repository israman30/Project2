//
//  GoogleViewController.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/26/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit
import SafariServices

class GoogleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var googlesArticle = [GoogleArticles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        requestAndReloadTableView()
    }
    
    func requestAndReloadTableView() {
        googlesArticle = []
        self.tableView.reloadData()
        fetchData(with: {arrayArticles in
            self.googlesArticle = arrayArticles!
            self.tableView.reloadData()
        })
        
    }

    func parseJson(data: Data, completionHandler: @escaping ([GoogleArticles]?) -> ()) {
        var newArticles : [GoogleArticles] = []
        if let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] {
            
            let realArticlesJson = jsonObject["articles"] as! [[String : Any]]
            for newArticle in realArticlesJson {
                let articles = GoogleArticles(data: newArticle)
                newArticles.append(articles)
            }
            DispatchQueue.main.async {
                completionHandler(newArticles)
            }
        }
    }
    
    func fetchData(with closure: @escaping ([GoogleArticles]?)->()){
        
        let urlString = "https://newsapi.org/v1/articles?source=google-news&sortBy=top&apiKey=066d82458ed84eeeac28a86095ec88b9"
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
        return googlesArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleCell", for: indexPath) as! GoogleTableViewCell
        
        let displayGoogle = googlesArticle[indexPath.row]
        
        cell.googleAuthor.text = displayGoogle.author
        cell.googleTitle.text = displayGoogle.title
        cell.googleDescription.text = displayGoogle.description
        cell.googlePublish.text = displayGoogle.publishedAt
        let googlePic = displayGoogle
        cell.updateCell(cellData: googlePic)
//        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safariVC = SFSafariViewController(url: URL(string: googlesArticle[indexPath.row].url!)!)
        present(safariVC, animated: true, completion: nil)
    }
    
    var urlString:String = "https://google.com"
    
    @IBAction func googleSearch(_ sender: Any) {
        
        let svc = SFSafariViewController(url: NSURL(string: self.urlString)! as URL)
        self.present(svc, animated: true, completion: nil)
    }
}
