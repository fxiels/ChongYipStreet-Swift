//
//  CYSMotionView.swift
//  ChongYipStreet
//
//  Created by David Yu on 29/2/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

protocol CYSMotionViewDelegate {
    func motionViewDidSelectSettingButton()
    func motionViewDidSelectSearchButton()
    func motionViewDidSelectServiceButton()
    func motionViewDidSelectFeedbackButton()
    func motionViewDidSelectCancelButton()
    func motionViewDidSelectItemButtonWithIndex(index: Int)
}

class CYSMotionView: UIView {
    
    var _settingButton: UIButton!
    var _searchButton: UIButton!
    var _serviceButton: UIButton!
    var _titleLabel: UILabel!
    var _feedbackButton: UIButton!
    var _cancelButton: UIButton!
    var _itemButtons = [UIButton]()
    var _delegate: CYSMotionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        self.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.height.equalTo(40)
        }

        _settingButton = UIButton()
        _settingButton.backgroundColor = UIColor.whiteColor()
        _settingButton.setTitle("设置", forState: .Normal)
        _settingButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        _settingButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        _settingButton.addTarget(self, action: "actionSetting", forControlEvents: .TouchUpInside)
        view.addSubview(_settingButton)
        _settingButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.width.height.equalTo(40)
        }
        
        _searchButton = UIButton()
        _searchButton.backgroundColor = UIColor.whiteColor()
        _searchButton.setImage(UIImage(named: ""), forState: .Normal)
        _searchButton.addTarget(self, action: "actionSearch", forControlEvents: .TouchUpInside)
        view.addSubview(_searchButton)
        _searchButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(_settingButton.snp_right).offset(10)
            make.width.height.equalTo(40)
        }

        _serviceButton = UIButton()
        _serviceButton.backgroundColor = UIColor.whiteColor()
        _serviceButton.setImage(UIImage(named: ""), forState: .Normal)
        _serviceButton.addTarget(self, action: "actionService", forControlEvents: .TouchUpInside)
        view.addSubview(_serviceButton)
        _serviceButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(_searchButton.snp_right).offset(10)
            make.width.height.equalTo(40)
        }

        _feedbackButton = UIButton()
        _feedbackButton.backgroundColor = UIColor.whiteColor()
        _feedbackButton.setImage(UIImage(named: ""), forState: .Normal)
        _feedbackButton.addTarget(self, action: "actionFeedback", forControlEvents: .TouchUpInside)
        view.addSubview(_feedbackButton)
        _feedbackButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.right.equalTo(-10)
            make.width.height.equalTo(40)
        }

        let colors = [UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor(), UIColor.redColor()]
        let titles = ["写帖子", "写文章", "写方案", "个人名片", "找团队", "便签"]
        for i in 0..<0 {
            let btn = UIButton()
            btn.backgroundColor = colors[i]
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 40
            btn.setImage(UIImage(named: ""), forState: .Normal)
            btn.setTitle(titles[i], forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            btn.addTarget(self, action: "actionItem:", forControlEvents: .TouchUpInside)
            self.addSubview(btn)
            _itemButtons.append(btn)
            btn.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(40+20+100*(i/3))
                make.width.height.equalTo(80)
                make.left.equalTo((Device_Width-240.0)/CGFloat(4*(i%3)))
            }
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-50)
            make.width.height.equalTo(40)
            make.centerX.equalTo(self.snp_centerX)
        }

        _cancelButton = UIButton()
        _cancelButton.backgroundColor = UIColor.whiteColor()
        _cancelButton.setImage(UIImage(named: ""), forState: .Normal)
        _cancelButton.addTarget(self, action: "actionCancel", forControlEvents: .TouchUpInside)
        self.addSubview(_cancelButton)
        _cancelButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(0)
            make.width.height.equalTo(40)
            make.centerX.equalTo(self.snp_centerX)
        }
    }
    
    func actionSetting() {
        _delegate?.motionViewDidSelectSettingButton()
    }
    
    func actionSearch() {
        _delegate?.motionViewDidSelectSearchButton()
    }
    
    func actionService() {
        _delegate?.motionViewDidSelectServiceButton()
    }
    
    func actionFeedback() {
        _delegate?.motionViewDidSelectFeedbackButton()
    }
    
    func actionCancel() {
        _delegate?.motionViewDidSelectCancelButton()
    }
    
    func actionItem(button: UIButton) {
        let index = _itemButtons.indexOf(button)
        _delegate?.motionViewDidSelectItemButtonWithIndex(index!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
