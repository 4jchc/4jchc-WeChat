//
//  WCBaseLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCBaseLoginViewController: UIViewController {
    

    ///供子类调用
    func login(){
        
        //隐藏键盘
        self.view.endEditing(true)
        
        // 登录之前给个提示
        
        MBProgressHUD.showMessage("正在登录中...", toView: self.view)
        
        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        weak var weakSelf = self
        app.registerOperation = false
        app.xmppUserLogin({ (type) -> Void in
            
            weakSelf?.handleResultType(type)
            
        })
    }
    
    
    func handleResultType(type:XMPPResultType){
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            switch (type) {
            case XMPPResultType.LoginSuccess:
                NSLog("登录成功");
                self.enterMainPage()
                
            case XMPPResultType.LoginFailure:
                NSLog("登录失败");
                MBProgressHUD.showError("用户名或者密码不正确", toView:self.view)
                
            case XMPPResultType.NetErr:
                MBProgressHUD.showError("网络不给力", toView:self.view)
            default: break
                
            }
        }
    }
    
    ///结束
    func enterMainPage(){
        // 更改用户的登录状态为YES
        WCUserInfo.sharedWCUserInfo.loginStatus = true
        
        // 把用户登录成功的数据，保存到沙盒
        WCUserInfo.sharedWCUserInfo.saveUserInfoToSanbox()
        
        //MARK: modal出来的模态窗口一定要隐藏不然会强引用
        self.dismissViewControllerAnimated(false, completion: nil)
        // 登录成功来到主界面
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.view.window!.rootViewController = storyboard.instantiateInitialViewController();
        
    }
    
    
    deinit{
        
        print("*销毁*\(__FUNCTION__) \(super.classForCoder)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
