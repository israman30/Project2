//
//  GoogleTableViewCell.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/26/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class GoogleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var googleImage: UIImageView!

    @IBOutlet weak var googleTitle: UILabel!
    
    @IBOutlet weak var googleDescription: UILabel!
    
    @IBOutlet weak var googleAuthor: UILabel!
    
    @IBOutlet weak var googlePublish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(cellData: GoogleArticles) {
        let url = URL(string: cellData.imageURL!)
        
        DispatchQueue.global().async {
            do {
                let urlData = try Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.googleImage.image = UIImage(data: urlData)
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }


    
}
