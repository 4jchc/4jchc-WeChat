//
//  AppDelegate.swift
//  XMPP
//
//  Created by 蒋进 on 15/12/20.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

enum XMPPResultType {
    case LoginSuccess//登录成功
    case LoginFailure//登录失败
    //网络不给力
    case NetErr
    
}

@UIApplicationMain

/*
* 在AppDelegate实现登录

1. 初始化XMPPStream
2. 连接到服务器[传一个JID]
3. 连接到服务成功后，再发送密码授权
4. 授权成功后，发送"在线" 消息
*/

//// 1. 初始化XMPPStream
//-(void)setupXMPPStream;
//// 2.连接到服务器
//-(void)connectToHost;
//// 3.连接到服务成功后，再发送密码授权
//-(void)sendPwdToHost;
//// 4.授权成功后，发送"在线" 消息
//-(void)sendOnlineToHost;
//MARK: - 枚举

class AppDelegate: UIResponder, UIApplicationDelegate,XMPPStreamDelegate {


    ///定义闭包// XMPP请求结果的block
    typealias XMPPResultBlock = (type:XMPPResultType) -> Void
    ///初始化闭包
    var _resultBlock:XMPPResultBlock!




    var window: UIWindow?
    var _xmppStream: XMPPStream?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 程序一启动就连接到主机
        //self.connectToHost()
        // 设置导航栏背景
        WCNavigationController.setupNavTheme()
        
        // 从沙里加载用户的数据到单例
        WCUserInfo.sharedWCUserInfo.loadUserInfoFromSanbox()

        // 判断用户的登录状态，YES 直接来到主界面
        if(WCUserInfo.sharedWCUserInfo.loginStatus == true){
            // 3. 回到登录界面
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController();
            
            // 自动登录服务
            self.xmppUserLogin(nil)
        }
        return true
    }
    
    
    //MARK: - 私有方法
    //MARK:  初始化XMPPStream
    func setupXMPPStream(){
        
        _xmppStream = XMPPStream()
        // 设置代理
        _xmppStream!.addDelegate(self, delegateQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        
    }
    
    //MARK:  连接到服务器
    func connectToHost(){
        NSLog("开始连接到服务器");
        if (_xmppStream == nil) {
            self.setupXMPPStream()
        }
        
        
        // 设置登录用户JID
        //resource 标识用户登录的客户端 iphone android
        // 从单例获取用户名
        let user:String  = WCUserInfo.sharedWCUserInfo.user;

        let myJID:XMPPJID = XMPPJID.jidWithUser(user, domain: "4jbook-pro.local", resource: "iphone8")
        _xmppStream!.myJID = myJID;
        // 设置服务器域名
        _xmppStream!.hostName = "4jbook-pro.local";//不仅可以是域名，还可是IP地址
        
        // 设置端口 如果服务器端口是5222，可以省略
        _xmppStream!.hostPort = 5222;
        
        // 连接
        //发起连接
        do {
            try _xmppStream!.connectWithTimeout(100000)
            print("发起连接成功")
        }   catch {
            print("发起连接失败")
        }
        
    }
    
    
    //MARK:  连接到服务成功后，再发送密码授权
    func sendPwdToHost(){
        NSLog("再发送密码授权");
        // 从沙盒里获取密码
        // 从单例获取用户名
        let pwd:String  = WCUserInfo.sharedWCUserInfo.pwd;
        do {
            try _xmppStream!.authenticateWithPassword(pwd)
            print("发送密码成功")
        }   catch {
            print("发送密码失败")
        }
        
    }
    //MARK:   授权成功后，发送"在线" 消息
    func sendOnlineToHost(){
        
        NSLog("发送 在线 消息");
        let presence: XMPPPresence  = XMPPPresence()
        NSLog("%@",presence);
        
        _xmppStream?.sendElement(presence)
        
    }
    
    //MARK:  XMPPStream的代理
    //MARK:  与主机连接成功
    func xmppStreamDidConnect(sender:XMPPStream){
        NSLog("与主机连接成功");
        
        // 主机连接成功后，发送密码进行授权
        self.sendPwdToHost()
    }
    
    //MARK:   与主机断开连接
    func xmppStreamDidDisconnect(sender: XMPPStream!, withError error: NSError?) {
        
        // 如果有错误，代表连接失败
        // 💗如果没有错误，表示正常的断开连接(人为断开连接)
        if (_resultBlock != nil && error != nil) {
            _resultBlock!(type:.NetErr)
        }
        print("**与主机断开连接")
    }
    
    
    
    //MARK:  授权成功
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        NSLog("授权成功");
        // 主机连接成功后，发送密码进行授权
        self.sendOnlineToHost()
        // 回调控制器登录成功
        // 判断block有无值，再回调给登录控制器
        if (_resultBlock != nil) {
            _resultBlock!(type:.LoginSuccess)
        }
   
    }
    
    
    //MARK:  授权失败
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        
        NSLog("授权失败 %@",error);
        // 判断block有无值，再回调给登录控制器
        if (_resultBlock != nil) {
            _resultBlock!(type: .LoginFailure)
        }
    }
    
    
    //MARK:  -公共方法
    ///用户注销
    func xmppUserlogout(){
        // 1." 发送 "离线" 消息"
        
        let offline: XMPPPresence = XMPPPresence(type: "unavailable")
        _xmppStream?.sendElement(offline)
        
        // 2. 与服务器断开连接
        _xmppStream!.disconnect()

        // 3. 回到登录界面
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        self.window!.rootViewController = storyboard.instantiateInitialViewController();
        
        //4.更新用户的登录状态
        WCUserInfo.sharedWCUserInfo.loginStatus = false
        WCUserInfo.sharedWCUserInfo.saveUserInfoToSanbox()
    
    }

    ///用户登录
    func xmppUserLogin(resultBlock:XMPPResultBlock?){
        
        // 先把block存起来
        _resultBlock = resultBlock;
        //MARK: 如果以前连接过服务，要断开
        _xmppStream?.disconnect()
        // 连接主机 成功后发送密码
        self.connectToHost()
    }

    
}

