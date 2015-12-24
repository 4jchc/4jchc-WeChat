//
//  WCEditProfileViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/23.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
///*****✅1.1定义代理协议
protocol WCEditProfileViewControllerDelegate:NSObjectProtocol{
    
    
    func editProfileViewControllerDidSave()
    
    
    
}

class WCEditProfileViewController: UITableViewController {
    

    var cell:UITableViewCell!

    ///*****✅1.2初始化代理协议
    weak var delegate:WCEditProfileViewControllerDelegate!

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置标题和TextField的默认值
        self.title = self.cell.textLabel!.text;
        
        self.textField.text = self.cell.detailTextLabel!.text;
        
        
        // 右边添加个按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveBtnClick")
        
    }

    func saveBtnClick(){
        // 1.更改Cell的detailTextLabel的text
        self.cell.detailTextLabel!.text = self.textField.text;
        //更新cll的内容
        self.cell.layoutSubviews()
        
        // 2.当前的控制器消失
        
        self.navigationController!.popViewControllerAnimated(true)
        
        // 调用代理
        if self.delegate.respondsToSelector("editProfileViewControllerDidSave"){
            // 通知代理，点击保存按钮
            self.delegate.editProfileViewControllerDidSave()
        }
    }
    
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
