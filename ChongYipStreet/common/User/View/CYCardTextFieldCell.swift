//
//  CYCardTextFieldCell.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/27.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYCardTextFieldCell: UITableViewCell, UITextFieldDelegate {

    let leftLabel = UILabel(frame: CGRectMake(0,0,70,30))
    var textFieldBlock : ((textField : UITextField) ->())? = nil
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leftLabel.textAlignment = .Left
        self.leftLabel.font = UIFont.systemFontOfSize(15.0)
        self.leftLabel.textColor = UIColor.lightGrayColor()
        
        self.textField.delegate = self
        self.textField.leftView = leftLabel
        self.textField.leftViewMode = .Always
    }
    
    func setContent(placeholder : String, textString : String, editState : Bool){
        
        self.leftLabel.text = placeholder
        self.textField.text = textString
        self.textField.enabled = editState
    }


    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.textFieldBlock?(textField: textField)
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
