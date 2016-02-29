//
//  CYMyPostViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/27.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYMyPostViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate {

    let kIdentifier : String = "MyPostCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("回帖"),CYNSLocalizedString("发布"),CYNSLocalizedString("关注")]
    
    
    var tableView : UITableView = UITableView()
    var segmentedView   = CYCustomSegmentedView()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.translucent = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.translucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLayoutView()
        self.initNavigationBar()
        self.initLoadingData()
    }
    
    func initLoadingData(){
        
    }
    func initLayoutView(){
        
        
        self.segmentedView = CYCustomSegmentedView(frame: CGRectMake(0, 0, screenWidth(), 40), titles: kSegmentedTitles , delegate: self)
        self.view.addSubview(self.segmentedView)
        self.segmentedView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.registerNib(UINib(nibName: "CYTribuneCell", bundle: nil), forCellReuseIdentifier: kIdentifier)
        
        let layoutVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[segmentedView(40)]-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["segmentedView" : segmentedView,"tableView" : tableView])
        let segmentedViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentedView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["segmentedView" : segmentedView])
        let tableViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["tableView" : tableView])
        
        self.view.addConstraints(layoutVConstraints)
        self.view.addConstraints(segmentedViewHConstraints)
        self.view.addConstraints(tableViewHConstraints)
        
        self.tableViewReloadData()
    }
    func initNavigationBar(){
    
        self.title = CYNSLocalizedString("我的帖子")
        
        self.navigationItem.rightBarButtonItems =
            [UIBarButtonItem(title: CYNSLocalizedString("编辑"), style: .Plain, target: self, action: "actionEdit:"),
                UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionPost:") ]
    }
    
    //MARK:- NavigationEvent
    func actionEdit(messageItem : UIBarButtonItem){
        
    }
    func actionPost(messageItem : UIBarButtonItem){
        
    }

    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        
    }
    
}

//MARK:- TableViewDelegate
extension  CYMyPostViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewReloadData(){
        if false{
            self.tableView.separatorStyle = .None
        }
        else{
            self.tableView.separatorStyle = .SingleLine
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
        
        if let tribuneCell = cell as? CYTribuneCell{
            tribuneCell.contentImageView.image = UIImage(named: "201510296120828674")
            tribuneCell.typeLabel.text = "商业"
            tribuneCell.titleLable.text = "撒打算打算打算打算打算的"
            tribuneCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            tribuneCell.likeButton.setTitle("110", forState: .Normal)
            tribuneCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}
