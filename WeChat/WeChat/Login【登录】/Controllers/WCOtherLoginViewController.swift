//
//  WCOtherLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/21.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCOtherLoginViewController: UIViewController {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!

    @IBOutlet weak var rightConstraint: NSLayoutConstraint!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pwdField: UITextField!

    @IBAction func loginBtn(sender: UIButton) {
        // 登录
        /*
        * 官方的登录实现
        * 1.把用户名和密码放在沙盒
        * 2.调用 AppDelegate的一个login 连接服务并登录
        */
        let user: NSString = self.userField.text!;
        let pwd: NSString  = self.pwdField.text!;
        
        let defaults: NSUserDefaults  = NSUserDefaults.standardUserDefaults()
        defaults.setObject(user, forKey: "user")
        defaults.setObject(pwd, forKey: "pwd")
        defaults.synchronize()
        
        //隐藏键盘
        self.view.endEditing(true)
        
        // 登录之前给个提示
        MBProgressHUD.showMessage("正在登录中...", toView: self.view)
    
        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            weak var weakSelf = self
        
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
            }
        }
    }
    
    ///结束
    func enterMainPage(){
        //MARK: modal出来的模态窗口一定要隐藏不然会强引用
        self.dismissViewControllerAnimated(false, completion: nil)
        // 登录成功来到主界面
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.view.window!.rootViewController = storyboard.instantiateInitialViewController();

    }
    

    @IBAction func cancel(sender: UIBarButtonItem) {
  
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    deinit{

        print("*销毁*\(__FUNCTION__) \(super.classForCoder)")
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "其它方式登录";
        
        // 判断当前设备的类型 改变左右两边约束的距离
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            self.leftConstraint.constant = 10;
            self.rightConstraint.constant = 10;
        }

        
        // 设置TextFeild的背景
        self.userField.background = UIImage.stretchedImageWithName("operationbox_text")
        
        self.pwdField.background = UIImage.stretchedImageWithName("operationbox_text")
        self.loginBtn.setla拉升Normal_Highlighted_BG("fts_green_btn","fts_green_btn_HL")
        
    }


    

  }
