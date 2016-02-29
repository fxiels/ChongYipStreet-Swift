//
//  CYCardTextViewCell.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/27.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYCardTextViewCell: UITableViewCell,UITextViewDelegate {


    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var textViewBlock : ((textView : UITextView) ->())? = nil
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
    }
    
    func setContent(placeholder : String, textString : String, editState : Bool){
        
        self.textView.text = textString
        self.textView.endEditing(editState)
        self.textViewLabel.text = placeholder
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        self.textViewBlock?(textView: textView)
        return true
    }
}
