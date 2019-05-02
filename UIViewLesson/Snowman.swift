//  Copyright © 2019 vb. All rights reserved.

import UIKit

enum Eye {
    
    case left, right
}

@IBDesignable
class Snowman: UIView {
    
    @IBInspectable
    var scale: CGFloat = 2.0
    
    @IBInspectable
    var isOpen: Bool = false
    
    @IBInspectable
    var mouthHappy: CGFloat = 0.0
    
    @IBInspectable
    var mouthConfussedLeft: CGFloat = 0.0
    
    @IBInspectable
    var mouthConfussedRight: CGFloat = 0.0
    
    var height: CGFloat {
        
        return min(self.bounds.size.width,
                   self.bounds.size.height)
    }
    
    private var firstCircleRadius: CGFloat {
        
        return height / 5 * scale
    }
    
    private var secondCircleRadius: CGFloat {
        
        return height / 7 * scale
    }
    
    private var headRadius: CGFloat {
        
        return height / 10 * scale
    }
    
    private var firstCircleCenter: CGPoint {
        
        return CGPoint(x: bounds.midX,
                       y: bounds.midY + firstCircleRadius + headRadius)
    }
    
    private var secondCircleCenter: CGPoint {
        
        return CGPoint(x: bounds.midX,
                       y: bounds.midY + headRadius - secondCircleRadius)
    }
    
    private var headCenter: CGPoint {
        
        return CGPoint(x: bounds.midX,
                       y: bounds.midY - 2 * secondCircleRadius)
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye: Eye) -> CGPoint {
            
            let eyeOffset = headRadius / Constants.headRadiusToEyeOffset
            var eyeCenter = headCenter
            
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            
            return eyeCenter
        }
        
        var eyePath = UIBezierPath()
        
        let eyeCenter = centerOfEye(eye)
        
        let eyeRadius = headRadius / Constants.headRadiusToEyeCenter
        
        if isOpen {
            
            eyePath = UIBezierPath(arcCenter: eyeCenter,
                                   radius: eyeRadius,
                                   startAngle: 0.0,
                                   endAngle: 2 * CGFloat.pi,
                                   clockwise: false)
            return eyePath
        }
        
        eyePath.move(to: CGPoint(x: eyeCenter.x  - eyeRadius, y: eyeCenter.y))
        
        eyePath.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        
        return eyePath
    }
    
    private func pathForFirstCicle() -> UIBezierPath {
        
        let firstCirclePath = UIBezierPath(arcCenter: firstCircleCenter,
                                           radius: firstCircleRadius,
                                           startAngle: 0.0,
                                           endAngle: 2 * CGFloat.pi,
                                           clockwise: false)
        firstCirclePath.lineWidth = 5
        
        return firstCirclePath
    }
    
    private func pathForSecondCicle() -> UIBezierPath {
        
        let secondCirclePath = UIBezierPath(arcCenter: secondCircleCenter,
                                            radius: secondCircleRadius,
                                            startAngle: 0.0,
                                            endAngle: 2 * CGFloat.pi,
                                            clockwise: false)
        secondCirclePath.lineWidth = 5
        
        return secondCirclePath
    }
    
    private func pathForHeadCicle() -> UIBezierPath {
        
        let headPath = UIBezierPath(arcCenter: headCenter,
                                    radius: headRadius,
                                    startAngle: 0.0,
                                    endAngle: 2 * CGFloat.pi,
                                    clockwise: false)
        headPath.lineWidth = 5
        
        return headPath
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthOffset = headRadius / Constants.headRadiusToMouthOffset
        let y = headCenter.y
        let x = headCenter.x - 2 * mouthOffset
        let width = 4 * mouthOffset
        let height = 2 * mouthOffset
        
        let mouthRect = CGRect(x: x,
                               y: y,
                               width: width,
                               height: height)
        
    
        let mouthPath = UIBezierPath()
        let mouthToWidthOffset = mouthRect.width * 0.3
        let start = CGPoint(x: mouthRect.minX,
                            y: mouthRect.midY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthToWidthOffset,
                          y: mouthRect.midY + min(1, max(mouthHappy * mouthConfussedRight * mouthConfussedLeft * height, -1)))
        let cp2 = CGPoint(x: mouthRect.maxX - mouthToWidthOffset,
                          y: mouthRect.midY + min(1, max(mouthHappy * mouthConfussedRight * mouthConfussedLeft * height, -1)))
        let end = CGPoint(x: mouthRect.maxX,
                          y: mouthRect.midY)
        mouthPath.move(to: start)
        mouthPath.addCurve(to: end,
                           controlPoint1: cp1,
                           controlPoint2: cp2)
        
        return mouthPath
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.blue.setStroke()
        pathForFirstCicle().stroke()
        UIColor.yellow.setStroke()
        pathForSecondCicle().stroke()
        UIColor.red.setStroke()
        pathForHeadCicle().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
}

enum Constants {
    
    static let headRadiusToEyeOffset: CGFloat = 3
    static let headRadiusToEyeCenter: CGFloat = 6
    static let headRadiusToMouthOffset: CGFloat = 3
}


