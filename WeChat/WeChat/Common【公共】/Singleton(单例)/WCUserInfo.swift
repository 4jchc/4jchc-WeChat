//
//  WCUserInfo.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/22.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
    let domain = "4jbook-pro.local"
class WCUserInfo: NSObject {
    
    let UserKey = "user"
    let LoginStatusKey = "LoginStatus"
    let PwdKey = "pwd"


    //计算属性(提供getter/setter)
    var jid : String {
        get{
            return "\(self.user)@\(domain)"
            
        }

    }

    /// 单例，全局访问入口
    internal static let sharedWCUserInfo = WCUserInfo()
    //用户名
    var user:String!
    //密码
    var pwd:String!
    
    /** 登录的状态 YES 登录过/NO 注销 */
    var loginStatus:Bool!
    
    //注册的用户名
    var registerUser:String!
    //注册的密码
    var registerPwd:String!
 
    

    //MARK: - //从沙盒里获取用户数据
    func loadUserInfoFromSanbox(){
        
        let defaults: NSUserDefaults  = NSUserDefaults.standardUserDefaults()
        self.user = defaults.objectForKey(UserKey) as? String
        self.pwd = defaults.objectForKey(PwdKey) as? String
        self.loginStatus = defaults.boolForKey(LoginStatusKey)
    }

    //MARK: - //保存用户数据到沙盒
    func saveUserInfoToSanbox(){
        
        /*
        * 官方的登录实现
        * 1.把用户名和密码放在沙盒
        * 2.调用 AppDelegate的一个login 连接服务并登录
        */
        let defaults: NSUserDefaults  = NSUserDefaults.standardUserDefaults()
        defaults.setObject(user, forKey: UserKey)
        defaults.setObject(pwd, forKey: PwdKey)
        defaults.setBool(loginStatus, forKey: LoginStatusKey)
        defaults.synchronize()
    }
  


}
