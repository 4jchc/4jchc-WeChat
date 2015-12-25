//
//  WCHistoryViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/24.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCHistoryViewController: UITableViewController {
    

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 监听一个登录状态的通知
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xxx:) name:UIKeyboardWillHideNotification object:nil];
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginStatusChange:", name: WCLoginStatusChangeNotification, object: nil)
    }
    
    func loginStatusChange(notification: NSNotification) {
        
        
        //通知是在子线程被调用，刷新UI在主线程
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            NSLog("%@",notification.userInfo!);
            // 获取登录状态
            let status = notification.userInfo!["loginStatus"] as! Int
     
            
            switch (status) {
            case XMPPResultType.Connecting.rawValue://正在连接
                
                self.indicatorView.startAnimating()
                
            case XMPPResultType.NetErr.rawValue://连接失败
                self.indicatorView.stopAnimating()
                
            case XMPPResultType.LoginSuccess.rawValue://登录成功也就是连接成功
                self.indicatorView.stopAnimating()
               
            case XMPPResultType.LoginFailure.rawValue://登录失败
                self.indicatorView.stopAnimating()
               
            default:
                break;
            }
        }
   
        
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
