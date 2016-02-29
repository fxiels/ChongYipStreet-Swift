//
//  CYSCommandViewController.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit




class CYSCommandViewController: CYSBaseViewController,CYCustomSegmentedViewDelegate {
    
    let commandService = CYCommandService()
    
    let kIdentifier : String = "CommandCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("全部"),CYNSLocalizedString("经验"),CYNSLocalizedString("相关"),CYNSLocalizedString("方案")]
    let kSubTitles : Array<String> = [CYNSLocalizedString("寻找"),CYNSLocalizedString("找方法"),CYNSLocalizedString("找团队"),CYNSLocalizedString("交流圈")]
    let kSubImages : Array<String> = ["cang","cang","cang","cang"]
    
    
    var tableView : UITableView = UITableView()
    
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
        self.commandService.loadGetCommandData(self.commandService.commandType)
    }
    func initLayoutView(){
        
        let segmentedView = CYCustomSegmentedView(frame: CGRectMake(0, 0, screenWidth(), 40), titles: kSegmentedTitles , delegate: self)
        
        self.view.addSubview(segmentedView)
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.registerNib(UINib(nibName: "CYCommandCell", bundle: nil), forCellReuseIdentifier: kIdentifier)
        
        let layoutVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[segmentedView(40)]-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["segmentedView" : segmentedView,"tableView" : tableView])
        let segmentedViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentedView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["segmentedView" : segmentedView])
        let tableViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["tableView" : tableView])
        
        self.view.addConstraints(layoutVConstraints)
        self.view.addConstraints(segmentedViewHConstraints)
        self.view.addConstraints(tableViewHConstraints)
        
        self.tableViewReloadData()
    }
    func initNavigationBar(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        let segmentedControl : UISegmentedControl = UISegmentedControl(items: [CYNSLocalizedString("热门"),CYNSLocalizedString("筛选")])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "updateTitleIndex:", forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segmentedControl
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionMessage:")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: "actionSearch:"),UIBarButtonItem(image: UIImage(named: "my_project.png"), style:.Done, target: self, action: "actionUserHome:")]
    }
    
    //MARK:- NavigationEvent
    func updateTitleIndex(segmentedControl : UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0{
        }
        else{
            
        }
    }
    func actionMessage(messageItem : UIBarButtonItem){
        
    }
    
    func actionUserHome(messageItem : UIBarButtonItem){
        let userHomeViewController = CYUserHomeViewController()
        self.navigationController?.pushViewController(userHomeViewController, animated: true)
    }
    func actionSearch(searchItem : UIBarButtonItem){
        let searchViewController = CYSearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    
    //MARK:- Nocationfi
    func addNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actionGetCommandDataFailed:", name: kNotificationGetCommandDataFailed, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actionGetCommandDataSucceed:", name: kNotificationGetCommandDataSucceed, object: nil)
    }
    
    func actionGetCommandDataFailed(notification : NSNotification){
        self.tableViewReloadData()
    }
    
    func actionGetCommandDataSucceed(notification : NSNotification){
        self.tableViewReloadData()
    }
    
    
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
        if selectIndex != self.commandService.commandType.rawValue, let commandType = CommandType(rawValue: selectIndex){
            
            self.commandService.commandType = commandType
            self.commandService.loadGetCommandData(commandType)
        }
    }
    
}


//MARK:- TableViewDelegate
extension CYSCommandViewController : UITableViewDelegate,UITableViewDataSource,CYCustomButtonsDelegate{
    
    func tableViewReloadData(){
        if self.commandService.getCommandDatasCount() > 0{
            self.tableView.separatorStyle = .None
        }
        else{
            self.tableView.separatorStyle = .SingleLine
        }
        
        if self.commandService.commandType == .All {
            let headerView = UIView(frame: CGRectMake(0, 0, screenWidth(), screenWidth() / CGFloat(kSubTitles.count)  + 220))
            
            var imageView = headerView.viewWithTag(1024) as? UIImageView
            var customButtons = headerView.viewWithTag(2048) as? CYCustomButtons
            
            if imageView == nil{
                imageView = UIImageView()
                imageView?.image = UIImage(named: "201510296120828674")
                headerView.addSubview(imageView ?? UIView())
            }
            if customButtons == nil{
                
                customButtons = CYCustomButtons(titles: kSubTitles, images: kSubImages,delegate: self)
                customButtons?.tag = 2048
                headerView.addSubview(customButtons ?? UIView())
            }
            
            imageView?.frame = CGRectMake(0, 0, screenWidth(), 200)
            customButtons?.frame = CGRectMake(0, 200, screenWidth(), customButtons?.getHeight() ?? 0)
            
            self.tableView.tableHeaderView = headerView
        }
        else{
            self.tableView.tableHeaderView = nil
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commandService.getCommandDatas().count + 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
        
        if let commandCell = cell as? CYCommandCell{
            commandCell.contentImageView.image = UIImage(named: "201510296120828674")
            commandCell.typeLabel.text = "商业"
            commandCell.contentLabel.numberOfLines = 0
            commandCell.contentLabel.text = "撒打算几点回家卡圣诞节喀什的空间啊是贷款计划"
            
            commandCell.likeButton.setTitle("110", forState: .Normal)
            commandCell.shoucanButton.setTitle("8888", forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let postViewController = CYPostViewController()
        postViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        self.tableViewReloadData()
    }
    
    func customButtons(customButton: CYCustomButtons, selectIndex: Int) {
        switch selectIndex{
        case 0:
            let seekViewController = CYSeekViewController()
            seekViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(seekViewController, animated: true)
        case 1:
            let programViewController = CYProgramViewController()
            programViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(programViewController, animated: true)
        case 2:
            let teamViewController = CYTeamViewController()
            teamViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(teamViewController, animated: true)
        case 3:
            let communicateViewController = CYCommunicateViewController()
            communicateViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(communicateViewController, animated: true)
        default:break
        }
    }
}
