//
//  CustomView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

protocol KTLayoutProtocol {
    init()
    func performLayout()
}

extension KTLayoutProtocol where Self: UIView {
    init(origin: CGPoint = CGPoint(x: 0,y: 0),
         topInset: CGFloat = 0,
         leftInset: CGFloat = 0,
         width: CGFloat = 0,
         height: CGFloat = 0,
         keepEqual: Bool = false) {
        
        let cx = origin.x + leftInset.scaleForScreenWidth()
        let cy = origin.y + topInset.scaleForScreenHeight()
        
        var cWidth = width.scaleForScreenWidth()
        var cHeight = height.scaleForScreenHeight()
        
        if keepEqual {
            if width == 0 {
                cWidth = cHeight
            }
            if height == 0 {
                cHeight = cWidth
            }
        }
        
        let newFrame = CGRect(x: cx, y: cy, width: cWidth, height: cHeight)
        
        self.init()
        self.frame = newFrame
        self.performLayout()
    }
}

extension UIView: KTLayoutProtocol {
    @objc public func performLayout() {}
}

extension Int {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Double {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension CGFloat {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / self
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / self
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Float {
    func scaleForScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func scaleForScreenWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension UIView {
    func topRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.minY)
    }
    
    func topMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.minY)
    }
    
    func topLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    func bottomRightPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
    }
    
    func bottomMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.maxY)
    }
    
    func bottomLeftPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.maxY)
    }
    
    func leftMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.midY)
    }
    
    func rightMidPoint() -> CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.midY)
    }
}
