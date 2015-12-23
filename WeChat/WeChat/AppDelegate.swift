//
//  AppDelegate.swift
//  XMPP
//
//  Created by 蒋进 on 15/12/20.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit



@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate,XMPPStreamDelegate {
    
    var window: UIWindow?


    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 沙盒的路径
        let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask, true).last

        NSLog("%@",documentPaths!)
        
        // 打开XMPP的日志
        DDLog.addLogger(DDTTYLogger.sharedInstance())

        
        
        
        // 程序一启动就连接到主机
        //self.connectToHost()
        // 设置导航栏背景
        WCNavigationController.setupNavTheme()
        
        // 从沙里加载用户的数据到单例
        WCUserInfo.sharedWCUserInfo.loadUserInfoFromSanbox()

        // 判断用户的登录状态，YES 直接来到主界面
        if(WCUserInfo.sharedWCUserInfo.loginStatus == true){
            // 3. 回到登录界面
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController();
            
            // 自动登录服务
            WCXMPPTool.sharedWCXMPPTool.xmppUserLogin(nil)
        }
        return true
    }
    
    

    
}

