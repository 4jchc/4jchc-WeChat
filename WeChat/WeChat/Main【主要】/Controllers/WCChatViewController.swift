//
//  WCChatViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/24.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextViewDelegate {
    
    var friendJid:XMPPJID!
    var _resultsContr: NSFetchedResultsController!
    
    
    //inputView底部约束
    var inputViewConstraint: NSLayoutConstraint!
    //MARK: -  懒加载
    lazy var tableView:UITableView = {
        
        let tableView = UITableView()
        //tableView.backgroundColor = UIColor.greenColor()
        tableView.dataSource = self;
        tableView.delegate = self
        //MARK: -  代码实现自动布局，要设置下面的属性为NO
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var InputView:WCInputView = {
        
        let inputView: WCInputView  = WCInputView.InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        return inputView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupView()
        
        // 添加观察者，监听键盘框架的变化
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: UIKeyboardWillShowNotification, object: nil)
        
        //键盘隐藏
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: UIKeyboardWillHideNotification, object: nil)
        // 加载数据
        self.loadMsgs()
    }
    
    
    /// 键盘变化监听方法
    func keyboardFrameChanged(notification: NSNotification) {
        
        if notification.name == UIKeyboardWillShowNotification {
            
            // 键盘结束的Frme
            let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            let height = rect.size.height
            
            let  duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            //竖屏{{0, 0}, {768, 264}
            //横屏{{0, 0}, {352, 1024}}
            //MARK: -  如果是ios7以下的，当屏幕是横屏，键盘的高底是size.with
            if (UIDevice.currentDevice().systemVersion as NSString).doubleValue < 8.0 && UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
                self.inputViewConstraint.constant = rect.size.width
                
            }
            self.inputViewConstraint.constant = height
            UIView.animateWithDuration(duration) {
                self.view.layoutIfNeeded()
            }
        }else{
            // 隐藏键盘的进修 距离底部的约束永远为0
            self.inputViewConstraint.constant = 0
        }
        //表格滚动到底部
        self.scrollToTableBottom()
    }
    
    
    func setupView(){
        // 代码方式实现自动布局 VFL
        // 创建一个Tableview
        self.view.addSubview(tableView)
        // 创建输入框View
        self.view.addSubview(InputView)
        
        // 设置TextView代理
        InputView.textView.delegate = self;
        // 自动布局
        
        // 水平方向的约束
        let views:NSDictionary = ["tableview":tableView,"inputView":InputView]
        // 1.tabview水平方向的约束
        let tabviewHConstraints: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableview]-0-|",options: [],metrics: nil,
            views: views as! [String : AnyObject]
        )
        self.view.addConstraints(tabviewHConstraints as! [NSLayoutConstraint])
        
        // 2.inputView水平方向的约束
        let inputViewHConstraints: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inputView]-0-|",options: [],metrics: nil,
            views: views as! [String : AnyObject]
        )
        self.view.addConstraints(inputViewHConstraints as! [NSLayoutConstraint])
        
        
        // 垂直方向的约束
        let vContraints: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[tableview]-0-[inputView(50)]-0-|",options: [],metrics: nil,
            views: views as! [String : AnyObject]
        )
        self.view.addConstraints(vContraints as! [NSLayoutConstraint])
        //MARK: - 代码创建的底部约束:
        self.inputViewConstraint = vContraints.lastObject as! NSLayoutConstraint
        NSLog("%@",vContraints);
    }
    
    //MARK: -  加载XMPPMessageArchiving数据库的数据显示在表格
    func loadMsgs(){
        
        // 上下文
        let context:NSManagedObjectContext = WCXMPPTool.sharedWCXMPPTool._msgStorage.mainThreadManagedObjectContext as NSManagedObjectContext
        
        // 请求对象
        let request:NSFetchRequest = NSFetchRequest(entityName: "XMPPMessageArchiving_Message_CoreDataObject")
        
        // 过滤、排序
        // 1.当前登录用户的JID的消息
        // 2.好友的Jid的消息
        let pre:NSPredicate = NSPredicate(format:"streamBareJidStr = %@ AND bareJidStr = %@",WCUserInfo.sharedWCUserInfo.jid ,self.friendJid.bare())
        
        NSLog("%@",pre);
        request.predicate = pre;
        
        // 时间升序
        let timeSort:NSSortDescriptor = NSSortDescriptor.init(key: "timestamp", ascending: true)
        
        request.sortDescriptors = [timeSort];
        
        // 查询
        _resultsContr = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        try! _resultsContr.performFetch()
        
        // 代理
        _resultsContr.delegate = self;
        
    }
    
    //MARK: -  表格的数据源
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _resultsContr.fetchedObjects?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID:String = "ChatCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID  as String)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }
        // 获取聊天消息对象
        let msg: XMPPMessageArchiving_Message_CoreDataObject = _resultsContr.fetchedObjects![indexPath.row] as! XMPPMessageArchiving_Message_CoreDataObject;
        //显示消息
        //显示消息
        if msg.outgoing.boolValue == true{//自己发
            
            cell!.textLabel!.text = "Me: \(msg.body)"
            cell?.textLabel?.textColor = UIColor.randomColor
        }else{
            cell!.textLabel!.text = "Other: \(msg.body)"
            cell?.textLabel?.textColor = UIColor.randomColor
        }
        
       // cell!.textLabel!.text = msg.body
        return cell!
    }
    
    
    
    
    //MARK: -  ResultController的代理
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        // 刷新数据
        self.tableView.reloadData()
        self.scrollToTableBottom()
    }
    
    //MARK: - TextView的代理
    
    func textViewDidChange(textView: UITextView) {
        
        let text:NSString = textView.text
 
        // 换行就等于点击了的send
        if text.rangeOfString("\n").length != 0{
            
            NSLog("发送数据 %@",text)
   
            self.sendMsgWithText(text)
            //清空数据
            textView.text = nil;
        }else{
            NSLog("%@",textView.text);
            
        }
    }

    
    
    //MARK: - 发送聊天消息
    func sendMsgWithText(text:NSString ){
        
        let msg:XMPPMessage = XMPPMessage(type: "chat" ,to:self.friendJid)

        // 设置内容
        msg.addBody(text as String)
     
        NSLog("%@",msg);
        
        WCXMPPTool.sharedWCXMPPTool._xmppStream?.sendElement(msg)
    }
    
    //MARK: - 滚动到底部
    func scrollToTableBottom(){
        
        let lastRow:Int = _resultsContr.fetchedObjects!.count - 1;
        let lastPath:NSIndexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        self.tableView.scrollToRowAtIndexPath(lastPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
