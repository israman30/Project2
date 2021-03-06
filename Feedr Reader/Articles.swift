//
//  Articles.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/14/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import Foundation

class GoogleArticles {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var imageURL: String?
    var publishedAt: String?
    
    init(data: [String : Any]) {
        author = data["author"] as? String ?? "unknown"
        title = data["title"] as? String ?? "unknown"
        description = data["description"] as? String ?? "unknown"
        url = data["url"] as? String ?? "unknown"
        imageURL = data["urlToImage"] as? String ?? "unknown"
        print(imageURL ?? 0)
        publishedAt = data["publishedAt"] as? String ?? "unknown"
        
    }

}
