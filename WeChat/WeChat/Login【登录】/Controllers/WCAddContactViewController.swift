//
//  WCAddContactViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/23.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCAddContactViewController: UITableViewController,UITextFieldDelegate {
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 添加好友
        
        // 1.获取好友账号
        let user:String  = textField.text!;
        print("\(user)");
        
        // 判断这个账号是否为手机号码
        if textField.isTelphoneNum() == false{
            UIAlertController.showAlert(self, title: "温馨提示", message: "请输入正确的手机号码", cancelButtonTitle: nil, okButtonTitle: "👌", otherButtonTitle: nil)
            //MBProgressHUD.showError("请输入正确的手机号码", toView: self.view)
            return true
        }

        
        
        //判断是否添加自己
        if "\(user)" == "\(WCUserInfo.sharedWCUserInfo.user)" {
            
        UIAlertController.showAlert(self, title: "温馨提示", message: "不能添加自己为好友", cancelButtonTitle: nil, okButtonTitle: "👌", otherButtonTitle: nil)

            return true
        }
        let jidStr: String  = "\(user)@\(domain)"
        
        let friendJid: XMPPJID = XMPPJID.jidWithString(jidStr)
        

        //判断好友是否已经存在
        
        if WCXMPPTool.sharedWCXMPPTool.rosterStorage.userExistsWithJID(friendJid, xmppStream: WCXMPPTool.sharedWCXMPPTool._xmppStream){
            
            UIAlertController.showAlert(self, title: "温馨提示", message: "当前好友已经存在", cancelButtonTitle: nil, okButtonTitle: "👌", otherButtonTitle: nil)
            
            return true
        }
            
        
        // 2.发送好友添加的请求
        // 添加好友,xmpp有个叫订阅
        WCXMPPTool.sharedWCXMPPTool._roster.subscribePresenceToUser(friendJid)
        return true

    }


    
    
    
    

override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

//override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    return 0
//}
//
//override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // #warning Incomplete implementation, return the number of rows
//    return 0
//}

    
    
    
    
    
    
/*
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

// Configure the cell...

return cell
}
*/

/*
// Override to support conditional editing of the table view.
override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
// Return false if you do not want the specified item to be editable.
return true
}
*/

/*
// Override to support editing the table view.
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
if editingStyle == .Delete {
// Delete the row from the data source
tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
} else if editingStyle == .Insert {
// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
}
}
*/

/*
// Override to support rearranging the table view.
override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
// Return false if you do not want the item to be re-orderable.
return true
}
*/

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

}
