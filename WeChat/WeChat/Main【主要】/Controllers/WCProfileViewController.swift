//
//  WCProfileViewController.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/23.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCProfileViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WCEditProfileViewControllerDelegate {
    
    //照片选择器懒加载
    lazy var imagePicker:UIImagePickerController? = {
        
        let ani = UIImagePickerController()
        
        return ani
    }()
    


    
    
    
    
    
    
    //头像
    @IBOutlet weak var haedView: UIImageView!
    //昵称
    @IBOutlet weak var nicknameLabel: UILabel!
    //微信号
    @IBOutlet weak var weixinNumLabel: UILabel!
    //公司
    @IBOutlet weak var orgnameLabel: UILabel!
    //部门
    @IBOutlet weak var orgunitLabel: UILabel!
    //职位
    @IBOutlet weak var titleLabel: UILabel!
    //电话
    @IBOutlet weak var phoneLabel: UILabel!
    //邮件
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置代理
        imagePicker!.delegate = self
        // 设置允许编辑
        imagePicker!.allowsEditing = true
        
        
        self.title = "个人信息";
        self.loadVCard()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  加载电子名片信息
     */
    func loadVCard(){
        //显示人个信息
        
        //xmpp提供了一个方法，直接获取个人信息
        let myVCard:XMPPvCardTemp = WCXMPPTool.sharedWCXMPPTool.vCard.myvCardTemp;
        
        // 设置头像
        if((myVCard.photo) != nil){
            self.haedView.image = UIImage(data: myVCard.photo)
        }
        
        // 设置昵称
        self.nicknameLabel.text = myVCard.nickname;
        
        // 设置微信号[用户名]
        
        self.weixinNumLabel.text = WCUserInfo.sharedWCUserInfo.user;
        
        // 公司
        self.orgnameLabel.text = myVCard.orgName;
        
        // 部门
        if (myVCard.orgUnits != nil) {
            
            self.orgunitLabel.text = myVCard.orgUnits[0] as? String;
            
        }
        
        //职位
        self.titleLabel.text = myVCard.title;
        
        //电话
        //MARK: -  myVCard.telecomsAddresses 这个get方法，没有对电子名片的xml数据进行解析
        // 使用note字段充当电话
        self.phoneLabel.text = myVCard.note;
        
        //邮件
        // 用mailer充当邮件
        //self.emailLabel.text = myVCard.mailer;
        
        //邮件解析
        if (myVCard.emailAddresses.count > 0) {
            //不管有多少个邮件，只取第一个
            self.emailLabel.text = myVCard.emailAddresses[0] as? String;
        }
    }
    
    
    
    // MARK: - Table view data source
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 获取cell.tag
        let cell: UITableViewCell  = tableView.cellForRowAtIndexPath(indexPath)!
        let tag:Int  = cell.tag;
        
        // 判断
        if (tag == 2) {//不做任务操作
            
            print("不做任务操作");
            return;
        }
        
        if(tag == 0){//选择照片
            print("选择照片");
            self.showAlert(self, title: "请选择", message: "", cancelButtonTitle: "取消" , okButtonTitle: "照相", otherButtonTitle: "相册")
  
            
        }else{//跳到下一个控制器
            print("跳到下一个控制器")
            self.performSegueWithIdentifier("EditVCardSegue", sender:cell)
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //获取编辑个人信息的控制destination
        let destVc = segue.destinationViewController;
        if destVc.isKindOfClass(WCEditProfileViewController.classForCoder()){
            
            let editVc:WCEditProfileViewController = destVc as! WCEditProfileViewController
            editVc.cell = sender as! UITableViewCell
            editVc.delegate = self;
        }

    }

    
    
     func showAlert(
        presentController: UIViewController!,
        title: String!,
        message: String,
        cancelButtonTitle: String?,
        okButtonTitle: String?,
        otherButtonTitle: String?) {
              weak var weakSelf = self
            
            let alert = UIAlertController(title: title!, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            if (cancelButtonTitle != nil) {
                
                alert.addAction(UIAlertAction(title: cancelButtonTitle!, style: UIAlertActionStyle.Default, handler: nil))// do not handle cancel, just dismiss
            }
            if (okButtonTitle != nil) {
                alert.addAction(UIAlertAction(title: okButtonTitle, style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    // 照相
                    self.imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera;
                    // 显示图片选择器
                    //MARK: - self的弱引用
                    weakSelf!.presentViewController(self.imagePicker!, animated: true, completion: nil)
    
                }))
                

            }
            if (otherButtonTitle != nil) {
                
                alert.addAction(UIAlertAction(title: otherButtonTitle, style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    
                    // 相册
                    self.imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                    // 显示图片选择器
                    weakSelf!.presentViewController(self.imagePicker!, animated: true, completion: nil)
                }))
            }
        
            presentController!.presentViewController(alert, animated: true, completion: nil)
    }

     //MARK: -  图片选择器的代理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("info")
        // 获取图片 设置图片
        let image: UIImage  = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.haedView.image = image;
        
        // 隐藏当前模态窗口
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // 更新到服务器
        self.editProfileViewControllerDidSave()

    }

    //MARK: -  编辑个人信息的控制器代理
    func editProfileViewControllerDidSave(){
        // 保存
        //获取当前的电子名片信息
        let myvCard: XMPPvCardTemp = WCXMPPTool.sharedWCXMPPTool.vCard.myvCardTemp;
        
        // 图片
        myvCard.photo = UIImagePNGRepresentation(self.haedView.image!);
        
        // 昵称
        myvCard.nickname = self.nicknameLabel.text;
        
        // 公司
        myvCard.orgName = self.orgnameLabel.text;
        
        // 部门
        if (self.orgunitLabel.text?.isEmpty == false ) {
            
            myvCard.orgUnits = [self.orgunitLabel.text!]
        }
        
        
        // 职位
        myvCard.title = self.titleLabel.text;
        
        
        // 电话
        myvCard.note =  self.phoneLabel.text;
        
        // 邮件
        //myvCard.mailer = self.emailLabel.text;

        if (self.emailLabel.text?.isEmpty == false) {
            myvCard.emailAddresses = [self.emailLabel.text!];
        }
        
        //更新 这个方法内部会实现数据上传到服务，无需程序自己操作
        WCXMPPTool.sharedWCXMPPTool.vCard.updateMyvCardTemp(myvCard)
        
    }
    
    deinit{
        print("**\(super.classForCoder)--已销毁")
        print("**\(imagePicker)--已销毁")
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
