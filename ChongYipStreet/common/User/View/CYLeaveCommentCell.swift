//
//  CYLeaveCommentCell.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/27.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYLeaveCommentCell: UITableViewCell {

  
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shoucanButton: UIButton!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.masksToBounds = true
        self.userImageView.layer.cornerRadius = 60 / 2.0
    }

    
}
