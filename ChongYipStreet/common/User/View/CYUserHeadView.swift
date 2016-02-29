//
//  CYUserHeadView.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/13.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

protocol CYUserHeadViewDelegate : NSObjectProtocol{
    func goUserHome(userHeadView : CYUserHeadView)
}
class CYUserHeadView: UIView {

    @IBOutlet weak var goHomeButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationValue: UILabel!
    
    @IBOutlet weak var FansLabel: UILabel!
    @IBOutlet weak var FansValue: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactValue: UILabel!
    
    @IBOutlet weak var likeValue: UILabel!
    
    weak var delegate : CYUserHeadViewDelegate? = nil
    
    static func initUserHeadView() ->CYUserHeadView{
        
        if let userHeadView = NSBundle.mainBundle().loadNibNamed("CYUserHeadView", owner: nil, options: nil).first as? CYUserHeadView {
        
            userHeadView.FansLabel.text = CYNSLocalizedString("粉丝")
            userHeadView.contactLabel.text = CYNSLocalizedString("联系")
            userHeadView.locationLabel.text = CYNSLocalizedString("所在地")
            
            userHeadView.goHomeButton.layer.cornerRadius = 10
            userHeadView.goHomeButton.layer.borderWidth  = 1
            userHeadView.goHomeButton.layer.borderColor = UIColor.grayColor().CGColor
            userHeadView.goHomeButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            userHeadView.goHomeButton.setTitle(CYNSLocalizedString("进入主页"), forState: .Normal)
            
            return userHeadView
        }
        
        return CYUserHeadView()
    }

    @IBAction func goHomeAction(sender: UIButton) {
        self.delegate?.goUserHome(self)
    }
    
}
