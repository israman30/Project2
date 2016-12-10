//
//  ArticleData.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/7/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import Foundation

class Articles {
    var author: String?
    var title: String?
    var description: String?
    init(article: [String : Any]) {
    
        author = article["author"] as? String
        title = article["title"] as? String
        description = article["description"] as? String
    }

}

class NewsApiResponse {
    var status : String?
    var source : String?
    var sortBy: String?
    var articles: [Articles]?
    
    init(json: [String : Any]) {
        status = json["status"] as? String
        source = json["source"] as? String
        sortBy = json["sortBy"] as? String
        
        articles = []
    
    
        if let articlesJson = json["articles"] as? [[String : Any]] {
            for articleJason in articlesJson {
                articles?.append(Articles(article: articleJason))
                
            }
        }
        
    }
}

class ArticleData {
   
    static func fetchData(closure: @escaping (Data) -> ()) {
        
        let endpoint = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=066d82458ed84eeeac28a86095ec88b9"
        let url = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { data, _ , _  in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
            
            let parsedResponse = NewsApiResponse(json: json)
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            DispatchQueue.main.async {
                closure(responseData)
            }
        }
        task.resume()
    }
    func fetchSearch(_ json: String) -> [Data]{
        return[]
    }

}
