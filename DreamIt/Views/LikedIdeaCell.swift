//
//  LikedIdeaCell.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-12.
//

import Foundation
import UIKit

class LikedIdeaCell: UITableViewCell {
    
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var ideaTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var impressions: UILabel!
    @IBOutlet weak var impressionImg: UIImageView!
    
    func setup(_ idea: IdeaItemModelView) {
        self.author.text = idea.author
        self.ideaTitle.text = idea.title
        self.impressions.text = idea.impressions
        self.postDate.text = idea.postDate
        self.thumbnail.image = UIImage(named: "test")
        self.thumbnail.layer.shadowColor = CGColor.init(gray: 1, alpha: 1)
        self.thumbnail.layer.shadowRadius = 4
        self.thumbnail.layer.shadowOffset = CGSize.init(width: 20, height: 20)
        
//        if idea.liked {
//            like.setImage(UIImage(named: "hand.thumbsup.fill"), for: .normal)
//        }
//        else {
//            like.setImage(UIImage(named: "hand.thumbsup"), for: .normal)
//        }
    }
    
    @IBAction func setLike() {
        if like.currentImage == UIImage(named: "hand.thumbsup") {
            like.setImage(UIImage(named: "hand.thumbsup.fill"), for: .normal)
        }
        else if like.currentImage == UIImage(named: "hand.thumbsup.fill") {
            like.setImage(UIImage(named: "hand.thumbsup"), for: .normal)
        }
    }
    
}
