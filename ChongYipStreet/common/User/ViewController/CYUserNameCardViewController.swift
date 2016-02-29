//
//  CYUserNameCardViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/27.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYUserNameCardViewController: UIViewController {

    let kCardTextViewIdentifier  : String = "CardTextViewCell"
    let kCardTextFieldIdentifier : String = "CardTextFieldCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userImageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameValue: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var editState : Bool = false
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNotification()
        self.initLayoutView()
        self.initNavigationBar()

    }
    
    func initLayoutView(){
        
        self.edgesForExtendedLayout = .None
        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.userImageView.layer.masksToBounds = true
        self.userImageView.layer.cornerRadius = 120.0 / 2.0
        self.userImageLabel.text = CYNSLocalizedString("点击更换头像")
        self.userNameLabel.text = CYNSLocalizedString("昵称:")
        self.userNameValue.text = "创业者"
        
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "CYCardTextViewCell", bundle: nil), forCellReuseIdentifier: kCardTextViewIdentifier)
        self.tableView.registerNib(UINib(nibName: "CYCardTextFieldCell", bundle: nil), forCellReuseIdentifier: kCardTextFieldIdentifier)
        
    }
    
    func initNavigationBar(){
        self.title = CYNSLocalizedString("用户名片")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: CYNSLocalizedString("编辑"), style: .Plain, target: self, action: "actionEdit:")
    }
    

    
    func initNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handShowNotification:", name:UIKeyboardDidShowNotification , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handHideNotification:", name:UIKeyboardDidHideNotification , object: nil)
    }

    func actionEdit(editButton : UIButton){
        if self.editState{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: CYNSLocalizedString("编辑"), style: .Plain, target: self, action: "actionEdit:")
        }
        else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: CYNSLocalizedString("完成"), style: .Plain, target: self, action: "actionEdit:")
        }
        self.editState = !self.editState
        self.tableViewReloadData()
    }
    
    func handShowNotification(notification : NSNotification){
        
        if let userInfo = notification.userInfo, let boardValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
            let boardFrame = boardValue.CGRectValue()
            
            self.tableViewBottomConstraint.constant = boardFrame.size.height
            UIView.animateWithDuration(0.3) { () -> Void in
                self.view.layoutIfNeeded()
            }
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    func handHideNotification(notification : NSNotification){
        self.tableViewBottomConstraint.constant = 0
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: other Even
    override func  touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(false)
    }
}





//MARK:- TableViewDelegate
extension CYUserNameCardViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewReloadData(){
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  7
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row < 4 ? 40 : 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        
        let kIdentifier = row < 4 ? kCardTextFieldIdentifier : kCardTextViewIdentifier
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
        
        var textString : String  = ""
        var placeholder : String = ""
        
        switch row{
        case 0:
            placeholder = "姓名"
            textString = "支付宝"
        case 1:
            placeholder = "所在地"
            textString = "支付宝"
        case 2:
            placeholder = "毕业学校"
            textString = "支付宝"
        case 3:
            placeholder = "出生年代"
            textString = "支付宝"
        case 4:
            placeholder = "个人介绍"
            textString = "支付宝"
        case 5:
            placeholder = "擅长方面"
            textString = "支付宝"
        case 6:
            placeholder = "用户需求"
            textString = "支付宝"
        default:break
        }
        
        
        if let cardTextFieldCell = cell as? CYCardTextFieldCell{
            cardTextFieldCell.setContent(placeholder, textString: textString, editState : self.editState)
            cardTextFieldCell.textFieldBlock = {
                (textField : UITextField) in
                switch row{
                case 0:
                    placeholder = "姓名"
                    textString = "支付宝"
                    NSLog("姓名:\(textField.text)")
                case 1:
                    placeholder = "所在地"
                    textString = "支付宝"
                    NSLog("所在地:\(textField.text)")
                case 2:
                    placeholder = "毕业学校"
                    textString = "支付宝"
                    NSLog("出生年代:\(textField.text)")
                case 3:
                    placeholder = "出生年代"
                    textString = "支付宝"
                    NSLog("毕业学校:\(textField.text)")
                default:break
                }
            }
        }
        else if let cardTextViewCell = cell as? CYCardTextViewCell{
            cardTextViewCell.setContent(placeholder, textString: textString, editState : self.editState)
            cardTextViewCell.textViewBlock = {
                (textView : UITextView) in
                
                switch row{
                case 4:
                    NSLog("个人介绍:\(textView.text)")
                case 5:
                    NSLog("擅长方面:\(textView.text)")
                case 6:
                    NSLog("用户需求:\(textView.text)")
                default:break
                }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.tableViewReloadData()
    }
    
    
}








