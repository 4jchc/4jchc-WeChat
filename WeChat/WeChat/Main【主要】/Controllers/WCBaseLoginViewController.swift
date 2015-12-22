//
//  WCBaseLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCBaseLoginViewController: UIViewController {

//    
//    func login(){
//    // 登录
//    
//
//    
//    //隐藏键盘
//    [self.view endEditing:YES];
//    
//    // 登录之前给个提示
//    
//    [MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
//    
//    [WCXMPPTool sharedWCXMPPTool].registerOperation = NO;
//    __weak typeof(self) selfVc = self;
//    
//    [[WCXMPPTool sharedWCXMPPTool] xmppUserLogin:^(XMPPResultType type) {
//    [selfVc handleResultType:type];
//    }];
//        
//        
//        
//        // 登录
//        /*
//        * 官方的登录实现
//        * 1.把用户名和密码放在WCUserInfo的单例
//        * 2.调用 AppDelegate的一个login 连接服务并登录
//        */
//        let user: NSString = self.userField.text!;
//        let pwd: NSString  = self.pwdField.text!;
//        
//        let defaults: NSUserDefaults  = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(user, forKey: "user")
//        defaults.setObject(pwd, forKey: "pwd")
//        defaults.synchronize()
//        
//        //隐藏键盘
//        self.view.endEditing(true)
//        
//        // 登录之前给个提示
//        MBProgressHUD.showMessage("正在登录中...", toView: self.view)
//        
//        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
//        weak var weakSelf = self
//        
//        app.xmppUserLogin({ (type) -> Void in
//            
//            weakSelf?.handleResultType(type)
//            
//        })
//    }
//    }
//
//
//


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
