//
//  UIButton+Extention.swift
//  WeChat
//
//  Created by 蒋进 on 15/12/21.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

    extension UIButton{
        
        ///设置正常-高亮状态
        func setNormal_Highlighted_BG(nbg:String, _ hbg:String){
            
            self.setBackgroundImage(UIImage(named: nbg), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage(named: hbg), forState: UIControlState.Highlighted)
            
        }
        ///设置正常-高亮拉升后状态
        func setla拉升Normal_Highlighted_BG(nbg:String, _ hbg:String){
            //用到uiimage的扩展方法
            self.setBackgroundImage(UIImage.stretchedImageWithName(nbg), forState: UIControlState.Normal)
            self.setBackgroundImage(UIImage.stretchedImageWithName(hbg), forState: UIControlState.Highlighted)

        }

        
    }
 

