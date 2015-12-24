//
//  WCInputView.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/24.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WCInputView: UIView {
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!


   static func InputView()->WCInputView {
        
        return NSBundle.mainBundle().loadNibNamed("WCInputView", owner: nil, options: nil).first as! WCInputView
        
    }
    
}
