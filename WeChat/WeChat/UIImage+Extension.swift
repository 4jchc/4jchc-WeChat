
//  Created by 蒋进 on 15/10/10.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
///*****✅返回一个截屏图片-剪切的头像
extension UIImage {
    
    
    
///*****✅返回一个截屏图片
   func imageWithCaptureView(view:UIView) -> UIImage{
        
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
    
    // 获取上下文
    let ctx:CGContextRef = UIGraphicsGetCurrentContext()!

    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    view.layer.renderInContext(ctx)

    // 获取截屏图片
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()

    // 关闭上下文
    UIGraphicsEndImageContext();
    
    ////*****✅/ 把图片转换成png格式的二进制数据
    //   let d:NSData = UIImagePNGRepresentation(newImage)!
    
    ////*****✅/ 写入桌面
    //还没实现
    //   d.writeToFile("/Users/jiangjin/Desktop/newImage.png", atomically: true)
    
        
    return newImage;
        
}
    
    
    
    
///*****✅返回一个剪切的头像 border:
    func imageWithHeader(name:NSString, border:CGFloat,borderColor color:UIColor) ->UIImage{

        // 圆环的宽度
        let borderW:CGFloat = border;
        
        // 加载旧的图片
        let oldImage:UIImage =  UIImage(named: name as String)!
        
        // 新的图片尺寸
        
        let imageW:CGFloat = oldImage.size.width + 2 * borderW;
        let imageH:CGFloat  = oldImage.size.height + 2 * borderW;
        
        // 设置新的图片尺寸
        let circirW:CGFloat  = imageW > imageH ? imageH : imageW;
        
        // 开启上下文
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirW, circirW), false, 0.0);
        
        // 画大圆
        let path:UIBezierPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, circirW, circirW))
   
        // 获取当前上下文
        let ctx:CGContextRef = UIGraphicsGetCurrentContext()!
        
        // 添加到上下文
        CGContextAddPath(ctx, path.CGPath);
        
        // 设置颜色
        color.set()
        
        // 渲染
        CGContextFillPath(ctx);
        
        let clipR:CGRect = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
        
        // 画圆：正切于旧图片的圆
        let clipPath:UIBezierPath = UIBezierPath(ovalInRect: clipR)
 
        // 设置裁剪区域
        clipPath.addClip()
    
        // 画图片
        oldImage.drawAtPoint(CGPointMake(borderW, borderW))

        // 获取新的图片
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        
        UIGraphicsEndImageContext();
        
        ////*****✅/ 把图片转换成png格式的二进制数据
     //   let d:NSData = UIImagePNGRepresentation(newImage)!
        
        ////*****✅/ 写入桌面
        //还没实现
     //   d.writeToFile("/Users/jiangjin/Desktop/\(name).png", atomically: true)
        
        return newImage;
        }
    

    //MARK: -UIColor 转UIImage
    /// UIColor 转UIImage
    static func createImageWithColor(color:UIColor) ->UIImage  {
        let  rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect);
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage;
        
    }
    //MARK: -返回中心拉伸的图片
    ///返回中心拉伸的图片
   class func stretchedImageWithName(name:String )->UIImage{
    
        let image: UIImage  = UIImage(named: name)!
        let leftCap: Int  = Int(image.size.width * 0.5)
      
        let topCap: Int  = Int(image.size.height * 0.5)
        return image.stretchableImageWithLeftCapWidth(leftCap, topCapHeight: topCap)
        
    }
  }

