//
//  WCMeViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/21.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCMeViewController: UITableViewController {
    

    /** 头像 */
    @IBOutlet weak var headerView: UIImageView!
    /** 昵称 */
    @IBOutlet weak var nickNameLabel: UILabel!
    /** 微信号 */
    @IBOutlet weak var weixinNumLabel: UILabel!

    
    
    
    @IBAction func logoutBtnClick(sender: AnyObject) {
//        //直接调用 appdelegate的注销方法
//        let app: AppDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
//        app.xmppUserlogout()
        WCXMPPTool.sharedWCXMPPTool.xmppUserlogout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadmyVCard()

    }

    
    func loadmyVCard(){
        
        // 显示当前用户个人信息
        
        // 如何使用CoreData获取数据
        // 1.上下文【关联到数据】
        
        // 2.FetchRequest
        
        // 3.设置过滤和排序
        
        // 4.执行请求获取数据
        
        //xmpp提供了一个方法，直接获取个人信息
        
        let myVCard: XMPPvCardTemp = WCXMPPTool.sharedWCXMPPTool.vCard.myvCardTemp
        
        // 设置头像
        if((myVCard.photo) != nil){
            self.headerView.image = UIImage(data: myVCard.photo)
        }
        
        // 设置昵称
        self.nickNameLabel.text = myVCard.nickname;
        
        // 设置微信号[用户名]
        
        let user: String  = WCUserInfo.sharedWCUserInfo.user;
        self.weixinNumLabel.text = "微信号:\(user)"
    }
    
    override func viewWillAppear(animated: Bool) {
        loadmyVCard()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    
    

    
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
