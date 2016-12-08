//
//  ArticleData.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/7/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import Foundation

class ArticleData {
    
    func fetchData(closure: @escaping (Data) -> ()) {
        
        let endpoint = "https://www.googleapis.com/books/v1/volumes?q=isbn:055380457X"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { data, _ , _  in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
            
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
