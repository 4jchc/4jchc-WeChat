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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置用户名为上次登录的用户名
        
        //从沙盒获取用户名
        let user:String  = WCUserInfo.sharedWCUserInfo.user
        self.userLabel.text = user;
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
