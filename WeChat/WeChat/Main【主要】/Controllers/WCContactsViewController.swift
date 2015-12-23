//
//  WCContactsViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/23.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCContactsViewController: UITableViewController {

  
    lazy var friends:NSArray? = {
        let ani = NSArray()
        return ani
    }()
    
    
    func loadFriends(){
        //使用CoreData获取数据
        // 1.上下文【关联到数据库XMPPRoster.sqlite】
        let context: NSManagedObjectContext  = WCXMPPTool.sharedWCXMPPTool.rosterStorage.mainThreadManagedObjectContext;
        
        
        // 2.FetchRequest【查哪张表】
        let request: NSFetchRequest  = NSFetchRequest(entityName: "XMPPUserCoreDataStorageObject")
        
        // 3.设置过滤和排序
        // 过滤当前登录用户的好友
        let jid: String  = WCUserInfo.sharedWCUserInfo.jid
        let pre: NSPredicate  = NSPredicate(format:"streamBareJidStr = %@",jid)
        request.predicate = pre;
        
        //排序
        let sort: NSSortDescriptor = NSSortDescriptor(key: "displayName", ascending:true)
        request.sortDescriptors = [sort]
        // 4.执行请求获取数据
        self.friends = try! context.executeFetchRequest(request)
        NSLog("%@",self.friends!);
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 从数据里加载好友列表显示
        self.loadFriends()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friends?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID:String = "ContactCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID  as String)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }
        // 获取对应好友
        let friend: XMPPUserCoreDataStorageObject = self.friends![indexPath.row] as! XMPPUserCoreDataStorageObject;
        cell!.textLabel!.text = friend.jidStr
        return cell!
    }


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
