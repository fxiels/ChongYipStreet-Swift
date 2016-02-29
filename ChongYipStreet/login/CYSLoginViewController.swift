//
//  CYSLoginViewController.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

class CYSLoginViewController: CYSBaseViewController {

    var _qqBtn: UIButton!
    var _weChatBtn: UIButton!
    var _weiBoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "login_bg.png")?.CGImage
        
        createSubViews()
    }

    func createSubViews() {
        let ratio = Device_Width>320 ?1:0.8
        let imageView = UIImageView(image: UIImage(named: "subject_title.png"))
        view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.height.equalTo(57*ratio)
            make.width.equalTo(176*ratio)
            make.bottom.equalTo(view.snp_centerY).offset(-60)
        }
        
        let loginBgView = UIView()
        view.addSubview(loginBgView)
        loginBgView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(80*ratio)
            make.left.right.equalTo(0)
            make.top.equalTo(view.snp_centerY).offset(10)
        }
        
        _weChatBtn = UIButton()
        _weChatBtn.layer.masksToBounds = true
        _weChatBtn.layer.cornerRadius = CGFloat(40*ratio)
        _weChatBtn.setImage(UIImage(named: "wechat.png"), forState: .Normal)
        _weChatBtn.addTarget(self, action: "actionWeChatLogin:", forControlEvents: .TouchUpInside)
        loginBgView.addSubview(_weChatBtn)
        _weChatBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.width.equalTo(80*ratio)
            make.centerX.equalTo(loginBgView.snp_centerX)
        }
        
        _qqBtn = UIButton()
        _qqBtn.layer.masksToBounds = true
        _qqBtn.layer.cornerRadius = CGFloat(40*ratio)
        _qqBtn.setImage(UIImage(named: "qq.png"), forState: .Normal)
        _qqBtn.addTarget(self, action: "actionQQLogin:", forControlEvents: .TouchUpInside)
        loginBgView.addSubview(_qqBtn)
        _qqBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.width.equalTo(80*ratio)
            make.right.equalTo(_weChatBtn.snp_left).offset(-20)
        }
        
        _weiBoBtn = UIButton()
        _weiBoBtn.layer.masksToBounds = true
        _weiBoBtn.layer.cornerRadius = CGFloat(40*ratio)
        _weiBoBtn.setImage(UIImage(named: "weibo.png"), forState: .Normal)
        _weiBoBtn.addTarget(self, action: "actionWeiBoLogin:", forControlEvents: .TouchUpInside)
        loginBgView.addSubview(_weiBoBtn)
        _weiBoBtn.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.width.equalTo(80*ratio)
            make.left.equalTo(_weChatBtn.snp_right).offset(20)
        }
    }
    
    //MARK: - 第三方登录
    func actionWeChatLogin(button: UIButton) {
        requestLogin()
    }
    
    func actionQQLogin(button: UIButton) {
        requestLogin()
    }
    
    func actionWeiBoLogin(button: UIButton) {
        requestLogin()
    }
    
    //MARK: - request
    func requestLogin() {
        loginSuccess()
    }
    
    //MARK: - 登录成功
    func loginSuccess() {
        NSNotificationCenter.defaultCenter().postNotificationName("LoginSuccess", object: nil)
    }
}
