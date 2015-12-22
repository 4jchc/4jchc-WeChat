

import Foundation

class WBLog{
    static func Log(message:String){
        #if DEBUG
            print("\(self.classForCoder)/n\(__LINE__)/n\(message)")
        #endif
    }
    
    static func Log(format: String, args: CVarArgType){
        #if DEBUG
            NSLog(format, args)
  
        #endif
    }

}

class p {
    static func shuchu(message:String){
        #if DEBUG
            NSLog(message)
        #endif
    }
    
    static func shuchu(format: String, args: CVarArgType){
        #if DEBUG
            NSLog(format, args)
        #endif
    }
}
extension UIView{
    
    static func shuchu(message:String){
        #if DEBUG
            NSLog(message)
        #endif
    }
    
    static func shuchu(format: String, args: CVarArgType){
        #if DEBUG
            NSLog(format, args)
        #endif
    }
    
    
    
}