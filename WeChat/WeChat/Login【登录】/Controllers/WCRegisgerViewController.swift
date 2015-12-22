//
//  WCRegisgerViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCRegisgerViewController: UIViewController {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBAction func registerBtnClick(sender: UIButton) {
        
        // 1.把用户注册的数据保存单例
        let userInfo: WCUserInfo = WCUserInfo.sharedWCUserInfo
        userInfo.registerUser = self.userField.text;
        userInfo.registerPwd = self.pwdField.text;
        
        
        // 2.调用AppDelegate的xmppUserRegister
        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
       // weak var weakSelf = self
        app.registerOperation = true
        app.xmppUserRegister({ (type) -> Void in
            
           // weakSelf?.handleResultType(type)
            
        })

    
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
    


}
