//
//  AppDelegate.swift
//  ChongYipStreet
//
//  Created by David Yu on 28/1/16.
//  Copyright © 2016年 yanwei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)
    var tabbar: UITabBarController! = UITabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window?.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccess", name: "LoginSuccess", object: nil)
        if CYSDataBaseManager.shareInstance._loginUser != nil {
            createTabBarController()
        }else {
            createLogin()
        }
        initAppKey()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func initAppKey() {
        Bmob.registerWithAppKey("d79495d3a4f3797a4615b12e43efae35")
    }
    
    func createTabBarController() {
        window?.rootViewController = tabbar
        let classNames = [CYSCommandViewController(), CYSTribuneViewController(), CYSProjectViewController(), CYSMineViewController()]
        let titles = ["推荐", "论坛", "项目", "我"]
        let normalImageNames = ["light_normal.png", "message_normal.png", "home_normal.png", "user_normal.png"]
        let selectImageNames = ["light_select.png", "message_select.png", "home_select.png", "user_select.png"]
        for i in 0 ..< classNames.count {
            initTabbarChilderViewControllers(classNames[i], withTitle: titles[i], andNormalImageName: normalImageNames[i], andSelectImageName: selectImageNames[i])
        }
    }
    
    func initTabbarChilderViewControllers(className: UIViewController, withTitle title: String, andNormalImageName normalImageName: String, andSelectImageName selectImageName: String) {
        let nv = CYSNavigationController(rootViewController: className)
        nv.title = title
        nv.tabBarItem.image = UIImage(named: normalImageName)
        nv.tabBarItem.selectedImage = UIImage(named: selectImageName)
        
        tabbar.addChildViewController(nv)
    }
    
    func createLogin() {
        let loginVC = CYSLoginViewController()
        window?.rootViewController = loginVC
    }
    
    func loginSuccess() {
        createLogin()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

