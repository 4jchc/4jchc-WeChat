//
//  WCLoginViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCLoginViewController: WCBaseLoginViewController {

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
        let user:String  = WCUserInfo.sharedWCUserInfo.user
        self.userLabel.text = user;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
