//
//  WCOtherLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/21.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCOtherLoginViewController: WCBaseLoginViewController {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!

    @IBOutlet weak var rightConstraint: NSLayoutConstraint!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pwdField: UITextField!

    @IBAction func loginBtn(sender: UIButton) {
        // 登录
        /*
        * 官方的登录实现
        * 1.把用户名和密码放在WCUserInfo的单例
        * 2.调用 AppDelegate的一个login 连接服务并登录
        */
        let userInfo: WCUserInfo = WCUserInfo.sharedWCUserInfo
        userInfo.user = self.userField.text;
        userInfo.pwd = self.pwdField.text;
        //调用父类的方法
        login()
    }
    



    @IBAction func cancel(sender: UIBarButtonItem) {
  
        self.dismissViewControllerAnimated(true, completion: nil)
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
