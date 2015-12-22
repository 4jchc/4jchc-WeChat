//
//  WCRegisgerViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
///*****✅1.1定义代理协议
protocol WCRegisgerViewControllerDelegate:NSObjectProtocol{
    

    /// 完成注册
    func regisgerViewControllerDidFinishRegister()

    
}

class WCRegisgerViewController: UIViewController {

    ///*****✅1.2初始化代理协议
    weak var delegate:WCRegisgerViewControllerDelegate!
    

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBAction func registerBtnClick(sender: UIButton) {
        
        self.view.endEditing(true)
        
        // 0.判断用户输入的是否为手机号码
        if self.userField.isTelphoneNum() == false{
            
            MBProgressHUD.showError("请输入正确的手机号码", toView:self.view)
            return;
        }
        // 1.把用户注册的数据保存单例
        let userInfo: WCUserInfo = WCUserInfo.sharedWCUserInfo
        userInfo.registerUser = self.userField.text;
        userInfo.registerPwd = self.pwdField.text;
        
        
        // 2.调用AppDelegate的xmppUserRegister
        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        app.registerOperation = true
        
        // 提示
        MBProgressHUD.showMessage("正在注册中....." ,toView:self.view)
        weak var weakSelf = self
        app.xmppUserRegister({ (type) -> Void in
            
            weakSelf?.handleResultType(type)
            
        })

    
    }
    /**
    *  处理注册的结果
    */
    func handleResultType(type:XMPPResultType){
        
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            switch (type) {
            case XMPPResultType.NetErr:
                
                MBProgressHUD.showError("网络不给力", toView:self.view)
            case XMPPResultType.RegisterSuccess:
                
                MBProgressHUD.showSuccess("注册成功", toView: self.view)
                // 回到上个控制器
                self.dismissViewControllerAnimated(true, completion:nil)
       
                if self.delegate.respondsToSelector("regisgerViewControllerDidFinishRegister"){
                    
                    self.delegate.regisgerViewControllerDidFinishRegister()
                }
                
            case XMPPResultType.RegisterFailure:
                
                MBProgressHUD.showError("注册失败,用户名重复", toView:self.view)
            default: break
        }
        
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        // 判断当前设备的类型 改变左右两边约束的距离
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone{
            self.leftConstraint.constant = 10;
            self.rightConstraint.constant = 10;
        }
        // 设置TextFeild的背景
        self.userField.background = UIImage.stretchedImageWithName("operationbox_text")
        
        self.pwdField.background = UIImage.stretchedImageWithName("operationbox_text")
        self.registerBtn.setla拉升Normal_Highlighted_BG("fts_green_btn","fts_green_btn_HL")
    }

    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func textChange(sender: AnyObject) {
        print("xxx");
        // 设置注册按钮的可能状态
        let enabled  = (self.userField.text?.isEmpty == false && self.pwdField.text?.isEmpty == false)
        self.registerBtn.enabled = enabled;
    }
    



}
