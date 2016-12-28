//
//  FoxSportsTableViewCell.swift
//  Feedr Reader
//
//  Created by Israel Manzo on 12/27/16.
//  Copyright © 2016 Israel Manzo. All rights reserved.
//

import UIKit

class FoxSportsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFox: UIImageView!
    
    @IBOutlet weak var titleFoxLbl: UILabel!
    
    @IBOutlet weak var descriptionFoxLbl: UILabel!
    
    @IBOutlet weak var authorFoxLbl: UILabel!
    
    @IBOutlet weak var publishedFoxLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(cellData: FoxArticles) {
        let url = URL(string: cellData.imageURL!)
        
        DispatchQueue.global().async {
            do {
                let urlData = try Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.imageFox.image = UIImage(data: urlData)
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
