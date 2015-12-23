//
//  WCLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCLoginViewController: WCBaseLoginViewController,WCRegisgerViewControllerDelegate {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!

    
    @IBAction func loginBtnClick(sender: UIButton) {
        
        // 保存数据到单例
        let userInfo: WCUserInfo = WCUserInfo.sharedWCUserInfo
        userInfo.user = self.userLabel.text;
        userInfo.pwd = self.pwdField.text;
        
        // 调用父类的登录
        super.login()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置TextField和Btn的样式
        self.pwdField.background = UIImage.stretchedImageWithName("operationbox_text")
        self.pwdField.addLeftViewWithImage("Card_Lock")
        
        self.loginBtn.setla拉升Normal_Highlighted_BG("fts_green_btn", "fts_green_btn_HL")

        // 设置用户名为上次登录的用户名
        //从沙盒获取用户名
        let user:String?  = WCUserInfo.sharedWCUserInfo.user
        self.userLabel.text = user;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 获取注册控制器
        let destVc = segue.destinationViewController

        if destVc.isKindOfClass(WCNavigationController.classForCoder()){
           
            let nav: WCNavigationController  = destVc as! WCNavigationController
            if nav.restorationIdentifier != "zhuce"{
                return
            }
            if ((nav.topViewController?.isKindOfClass(WCRegisgerViewController.classForCoder())) == true){
                //获取根控制器
                let registerVc: WCRegisgerViewController  = nav.topViewController as! WCRegisgerViewController
                // 设置注册控制器的代理
                registerVc.delegate = self;
            }

        }

    }

    
    //MARK: -  regisgerViewController的代理
    func regisgerViewControllerDidFinishRegister(){
        print("完成注册");
        // 完成注册 userLabel显示注册的用户名
        self.userLabel.text = WCUserInfo.sharedWCUserInfo.registerUser;
        
        // 提示
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.6 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            MBProgressHUD.showSuccess("请重新输入密码进行登录", toView:self.view)
        }
        
        
        
    }



}
