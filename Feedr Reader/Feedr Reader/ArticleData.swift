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
    
    init(data: [String : Any]) {
    
        author = data["author"] as? String ?? "unknown"
        title = data["title"] as? String ?? "unknown"
        description = data["description"] as? String ?? "unknown"
        print(description ?? "")
    }

}

