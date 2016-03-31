//
//  CardView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/31.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class CardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var icon = UIImageView()
    var title = UILabel()
    var originalFrame = CGRect()
    var circleImage = UIImageView()
    
    var leftLine = CAShapeLayer()
    var rightLine = CAShapeLayer()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        originalFrame = frame
        
        initSubviews()
        
    }
    
    func initSubviews() {
        layer.cornerRadius = 5 * scaleFactor
        layer.masksToBounds = true
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        title.center = CGPoint(x: frame.width / 2, y: frame.height / 5)
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        title.font = UIFont.systemFontOfSize(18 * scaleFactor)
        title.text = "阅读部分"
        addSubview(title)
        
        icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 60 * scaleFactor, height: 60 * scaleFactor))
        icon.center = CGPoint(x: frame.width / 2, y: frame.height * 3 / 5)
        addSubview(icon)
        
        circleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 85 * scaleFactor, height: 85 * scaleFactor))
        circleImage.center = CGPoint(x: self.frame.width / 2, y: 140 * scaleFactor)
        circleImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        circleImage.image = UIImage(named: "dynamiccircle")
        circleImage.alpha = 0
        addSubview(circleImage)
        
        rightLine.anchorPoint = CGPoint(x: 0, y: 0.5)
        rightLine.lineWidth = 3.5
        rightLine.strokeStart = 0
        rightLine.strokeEnd = 0
        rightLine.strokeColor = UIColor.whiteColor().CGColor
        rightLine.path = shortStrokePath()
        rightLine.position = CGPoint(x: self.frame.width / 2 + 30 * scaleFactor, y: 70 * scaleFactor)
        layer.addSublayer(rightLine)
        
        leftLine.anchorPoint = CGPoint(x: 0, y: 0.5)
        leftLine.lineWidth = 3.5
        leftLine.strokeStart = 1
        leftLine.strokeEnd = 1
        leftLine.strokeColor = UIColor.whiteColor().CGColor
        leftLine.path = shortStrokePath()
        leftLine.position = CGPoint(x: self.frame.width / 2 - screenWidth / 2, y: 70 * scaleFactor)
        layer.addSublayer(leftLine)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shortStrokePath() -> CGPathRef {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, screenWidth / 2 - 30 * scaleFactor, 0)
        return path
    }
    
    func expandingAnimation() {
        
        userInteractionEnabled = false
        
        UIView.animateWithDuration(0.2, delay: 0, options: [.CurveEaseIn], animations: { () -> Void in
            self.frame = CGRect(x: self.frame.origin.x , y: -20, width: self.frame.width, height: self.superview!.frame.height + 40)
            }) {_ -> Void in
                if let scroll = self.superview as? UIScrollView {
                    scroll.scrollEnabled = false
                }
                self.layer.masksToBounds = false
        }
        
        UIView.animateWithDuration(1.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: { () -> Void in
            self.title.font = UIFont.systemFontOfSize(14 * scaleFactor)
            self.title.center = CGPoint(x: self.frame.width / 2, y: 37 * scaleFactor)
            
            self.icon.transform = CGAffineTransformMakeScale(0.6, 0.6)
            self.icon.center = CGPoint(x: self.frame.width / 2, y: 140 * scaleFactor)
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.2, options: [], animations: { () -> Void in
            self.circleImage.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: { () -> Void in
            self.circleImage.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = NSNumber(float: 0)
        strokeEndAnimation.toValue = NSNumber(float: 1)
        strokeEndAnimation.duration = 0.33
        strokeEndAnimation.beginTime = CACurrentMediaTime() + 0.2
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        strokeEndAnimation.fillMode = kCAFillModeBackwards
        strokeEndAnimation.removedOnCompletion = false
        self.rightLine.addAnimation(strokeEndAnimation, forKey: nil)
        self.rightLine.strokeEnd = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = NSNumber(float: 1)
        strokeStartAnimation.toValue = NSNumber(float: 0)
        strokeStartAnimation.duration = 0.33
        strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        strokeStartAnimation.fillMode = kCAFillModeBackwards
        strokeStartAnimation.removedOnCompletion = false
        self.leftLine.addAnimation(strokeStartAnimation, forKey: nil)
        self.leftLine.strokeStart = 0
        
    }
    
    func resetAnimation() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: { () -> Void in
            self.circleImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0, options: [], animations: { () -> Void in
            self.circleImage.alpha = 0
            }, completion: nil)
        UIView.animateWithDuration(0.25, delay: 0.15, options: [.CurveEaseInOut], animations: { () -> Void in
            self.frame = self.originalFrame
            }) {_ -> Void in
                if let scroll = self.superview as? UIScrollView {
                    scroll.scrollEnabled = true
                }
                self.layer.masksToBounds = true
                self.userInteractionEnabled = true

        }
        UIView.animateWithDuration(1.5, delay: 0.15, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: { () -> Void in
            self.title.font = UIFont.systemFontOfSize(18 * scaleFactor)
            self.title.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 5)
            
            self.icon.transform = CGAffineTransformMakeScale(1, 1)
            self.icon.center = CGPoint(x: self.frame.width / 2, y: self.frame.height * 3 / 5)
            }, completion: nil)
        
        if self.rightLine.strokeEnd != 0 {
            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.fromValue = NSNumber(float: 1)
            strokeEndAnimation.toValue = NSNumber(float: 0)
            strokeEndAnimation.duration = 0.33
            strokeEndAnimation.beginTime = CACurrentMediaTime() + 0.1
            strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            strokeEndAnimation.fillMode = kCAFillModeBackwards
            strokeEndAnimation.removedOnCompletion = false
            self.rightLine.addAnimation(strokeEndAnimation, forKey: nil)
            self.rightLine.strokeEnd = 0
        }
        
        if self.leftLine.strokeStart != 1 {
            let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
            strokeStartAnimation.fromValue = NSNumber(float: 0)
            strokeStartAnimation.toValue = NSNumber(float: 1)
            strokeStartAnimation.duration = 0.33
            strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.1
            strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            strokeStartAnimation.fillMode = kCAFillModeBackwards
            strokeStartAnimation.removedOnCompletion = false
            self.leftLine.addAnimation(strokeStartAnimation, forKey: nil)
            self.leftLine.strokeStart = 1
        }
        
    }

}
