//
//  NewsTableViewCell.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/9/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var newsLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // MARK: Image fetching
    func updateCell(cellData: Articles) {
        let url = URL(string: cellData.imageURL!)
        
        DispatchQueue.global().async {
            do {
                let urlData = try Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.newsImage.image = UIImage(data: urlData)
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
