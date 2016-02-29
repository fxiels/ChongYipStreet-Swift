//
//  CYUserHomeViewController.swift
//  ChongYipStreet
//
//  Created by youyou5920 on 16/2/13.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYUserHomeViewController: CYSBaseViewController,CYUserHomeHeadViewDelegate,CYCustomSegmentedViewDelegate  {

    let kIdentifier : String = "UserHomeViewCell"
    
    let kSegmentedTitles : Array<String> = [CYNSLocalizedString("动态"),CYNSLocalizedString("相册")]
    
    let headView : CYUserHomeHeadView = CYUserHomeHeadView.inituserHomeHeadView()
    let tableView : UITableView = UITableView()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
    }
    
    func initLayoutView(){
    
        self.view.addSubview(self.headView)
        self.headView.delegate = self
        self.headView.translatesAutoresizingMaskIntoConstraints = false
        
        let segmentedView = CYCustomSegmentedView(frame: CGRectMake(0, 0, screenWidth(), 40), titles: kSegmentedTitles , delegate: self)
        self.view.addSubview(segmentedView)
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kIdentifier)
        
        
        let layoutVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[headView(160)]-0-[segmentedView(40)]-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["headView" : headView,"segmentedView" : segmentedView,"tableView" : tableView])
        
        let headViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[headView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["headView" : headView])
        let segmentedViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[segmentedView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["segmentedView" : segmentedView])
        let tableViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["tableView" : tableView])
        
        
        self.view.addConstraints(layoutVConstraints)
        self.view.addConstraints(headViewHConstraints)
        self.view.addConstraints(segmentedViewHConstraints)
        self.view.addConstraints(tableViewHConstraints)
        
        self.tableViewReloadData()
    }
    
    func initNavigationBar(){
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        titleLable.textAlignment = .Center
        titleLable.textColor = UIColor.whiteColor()
        titleLable.font = UIFont.systemFontOfSize(17)
        titleLable.text = CYNSLocalizedString("用户主页")
        self.navigationItem.titleView = titleLable
    }
    
    //MARK- CYUserHeadViewDelegate
    
    func goNameCard(userHomeHeadView: CYUserHomeHeadView) {
        let userNameCardViewController = CYUserNameCardViewController()
        self.navigationController?.pushViewController(userNameCardViewController, animated: true)
    }
    //MARK:- CYCustomSegmentedViewDelegate
    func customSegmentedView(segmentedView: CYCustomSegmentedView, selectIndex: Int) {
        
    }

}
//MARK:- TableViewDelegate
extension CYUserHomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableViewReloadData(){
        
        self.tableView.separatorStyle = .SingleLine
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kIdentifier, forIndexPath: indexPath)
    
        switch indexPath.item{
        case 0:cell.textLabel?.text = CYNSLocalizedString("项目")
        case 1:cell.textLabel?.text = CYNSLocalizedString("回帖")
        case 2:cell.textLabel?.text = CYNSLocalizedString("文章")
        case 3:cell.textLabel?.text = CYNSLocalizedString("方案")
        case 4:cell.textLabel?.text = CYNSLocalizedString("发帖")
        default:break;
        }
        
        var numberLabel = cell.contentView.viewWithTag(1024) as? UILabel
        if numberLabel == nil{
            
            numberLabel = UILabel()
            if let label = numberLabel{
                
                label.tag = 1024
                label.textAlignment = .Right
                label.translatesAutoresizingMaskIntoConstraints = false
                
                cell.contentView.addSubview(label)
                
                let numberLabelVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[numberLabel]-0-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["numberLabel":label])
                let numberLabelHConstraints =
                    [NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100),
                     NSLayoutConstraint(item: label, attribute: .Right, relatedBy: .Equal, toItem: cell.contentView, attribute: .Right, multiplier: 1.0, constant: -5)]
                
                cell.contentView.addConstraints(numberLabelHConstraints)
                cell.contentView.addConstraints(numberLabelVConstraints)
            }
            
        }
        numberLabel?.text = "9999"

        cell.accessoryType = .DisclosureIndicator
        
        return cell ?? UITableViewCell()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.item{
        case 0:
            let myPostViewController = CYMyPostViewController()
            self.navigationController?.pushViewController(myPostViewController, animated: true)
        case 1:
            let myPostViewController = CYMyPostViewController()
            self.navigationController?.pushViewController(myPostViewController, animated: true)
        case 2:
            let myPostViewController = CYMyPostViewController()
            self.navigationController?.pushViewController(myPostViewController, animated: true)
        case 3:
            let myPostViewController = CYMyPostViewController()
            self.navigationController?.pushViewController(myPostViewController, animated: true)
        case 4:
            let myPostViewController = CYMyPostViewController()
            self.navigationController?.pushViewController(myPostViewController, animated: true)
        default:break;
        }
    }
    
    
}