

import UIKit

public extension Double {
    
    public func isWholeNumber() -> Bool {
        if Double(Int(self)) == self {
            return true
        }
        return false
    }
    
}