//
//  CYSBaseViewController.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSBaseViewController: UIViewController {
    
    var _backgroundView: UIView!
    var _motionView: CYSMotionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        createMotionView()
        
        //MARK: - 测试数据
        let parameters = ["userName": "yw3", "userSex": false, "userAvator": "", "userId": "91897ddff2"]
        CYSHttpManager.shareInstance.requestChangeUserInfos(parameters, successClosure: { (data) -> Void in
            
            }, otherFailureClosure: { (data) -> Void in
                
            }) { (data) -> Void in
                
        }
    }
    
    //MARK: - 摇一摇显示的view
    func createMotionView() {
        _backgroundView = UIView(frame: UIScreen.mainScreen().bounds)
        _backgroundView.backgroundColor = UIColor.blackColor()
        _backgroundView.alpha = 0.7
        UIApplication.sharedApplication().keyWindow?.addSubview(_backgroundView)
        _backgroundView.hidden = true
        
        _motionView = CYSMotionView(frame: CGRectMake(0, Device_Height-320, Device_Width, 320))
        _motionView.backgroundColor = UIColor.whiteColor()
        UIApplication.sharedApplication().keyWindow?.addSubview(_motionView)
        _motionView.hidden = true
    }
    
    //MARK: - 设置_motionView显示状态
    func setMotionViewHiddeState(state: Bool) {
        _backgroundView.hidden = state
        _motionView.hidden = state
    }
    
    //MARK: - 摇一摇
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        super.motionEnded(motion, withEvent: event)
        setMotionViewHiddeState(false)
    }

    //MARK: - 跳转到登陆页面
    func login() {
        let loginVC = CYSLoginViewController()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.showViewController(loginVC, sender: nil)
    }
    
    
}

extension CYSBaseViewController: CYSMotionViewDelegate {
    func motionViewDidSelectSettingButton() {
    
    }
    
    func motionViewDidSelectSearchButton() {
    
    }
    
    func motionViewDidSelectServiceButton() {
    
    }
    
    func motionViewDidSelectFeedbackButton() {
    
    }
    
    func motionViewDidSelectCancelButton() {
        setMotionViewHiddeState(true)
    }
    
    func motionViewDidSelectItemButtonWithIndex(index: Int) {
    
    }

}
