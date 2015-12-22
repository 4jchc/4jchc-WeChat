//
//  WCNavigationController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/21.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCNavigationController: UINavigationController {
    
    // 设置导航栏的主题
   static func setupNavTheme(){
        // 设置导航样式
        
        let navBar:UINavigationBar = UINavigationBar.appearance()
        
        // 1.设置导航条的背景
        
        // 高度不会拉伸，但是宽度会拉伸
        navBar.setBackgroundImage(UIImage(named: "topbarbg_ios7"), forBarMetrics: UIBarMetrics.Default)
        
        // 2.设置栏的字体
        let att:NSMutableDictionary = NSMutableDictionary()
        att[NSForegroundColorAttributeName] = UIColor.whiteColor()
        att[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        navBar.titleTextAttributes = att as NSDictionary as? [String : AnyObject]
        // 设置状态栏的样式
        // xcode5以上，创建的项目，默认的话，这个状态栏的样式由控制器决定
        //MARK:配合plist文件设置--全局--状态栏样式
        //在plis文件中加入View controller-based status bar appearance.就不用每一个都设置了
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
       
        
    }
    //MARK: - 单独设置状态栏的样式
    //// 如果控制器是由导航控制管理，设置状态栏的样式时，要在导航控制器里设置
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIStatusBarStyle.LightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }





}
