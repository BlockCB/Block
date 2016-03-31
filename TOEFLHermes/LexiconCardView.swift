//
//  LexiconCardView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit
import SDWebImage

class LexiconCardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    static let aspectRatio: CGFloat = 1.125
    var wordLabel = UILabel()
    var detailsButton = UIButton()
    var speakerButton = UIButton()
    var favorButton = UIButton()
    var libLabel = UILabel()
    var backButton = UIButton()
    
    var frontView = UIView()
    var backView = UIView()
    var coverImageView = UIImageView()
    
    var cardColor = UIColor.whiteColor() {
        didSet {
            frontView.backgroundColor = cardColor
            backView.backgroundColor = cardColor
        }
    }
    
    static func calcHeigthWithWidth(width: CGFloat) -> CGFloat {
        return width * LexiconCardView.aspectRatio
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configViews() {
//        layer.cornerRadius = 10
//        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        
        frontView = UIView(frame: self.frame)
        frontView.layer.cornerRadius = 10
        frontView.layer.masksToBounds = true
        addSubview(frontView)
        
        backView = UIView(frame: self.frame)
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        self.backView.alpha = 0
        var identity = CATransform3DIdentity
        identity.m34 = 1.0/1000
        let angle = CGFloat(M_PI)
        let rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        backView.layer.transform = rotationTransform
        insertSubview(backView, belowSubview: frontView)
        
        
        
        //init imageview
        coverImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        coverImageView.backgroundColor = UIColor.whiteColor()
        frontView.addSubview(coverImageView)
//        coverImageView.sd_setImageWithURL(NSURL(string: "https://source.unsplash.com/random/520x560")!, placeholderImage: nil, options: .RefreshCached)

//        coverImageView.kf_setImageWithURL(NSURL(string: "https://source.unsplash.com/random/520x560")!,
//            placeholderImage: nil,
//            optionsInfo: [.ForceRefresh])
        
        let blackMask = UIView(frame: coverImageView.frame)
        blackMask.backgroundColor = UIColor(white: 0, alpha: 0.15)
        frontView.addSubview(blackMask)
        
        wordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width - 40 * scaleFactor, height: 80))
        wordLabel.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        wordLabel.minimumScaleFactor = 0.5
        wordLabel.font = UIFont.systemFontOfSize(40)
        wordLabel.textAlignment = .Center
        wordLabel.backgroundColor = UIColor.clearColor()
        wordLabel.textColor = UIColor.whiteColor()
        frontView.addSubview(wordLabel)
        
        let test = UILabel(frame: wordLabel.frame)
        test.text = "destination"
        test.textAlignment = .Center
        test.font = UIFont.systemFontOfSize(50)
        backView.addSubview(test)
        
        detailsButton = UIButton(type: .DetailDisclosure)
        detailsButton.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        detailsButton.tintColor = UIColor.whiteColor()
        detailsButton.addTarget(self, action: Selector("showDetails"), forControlEvents: .TouchUpInside)
        frontView.addSubview(detailsButton)
        
        backButton = UIButton(type: .Custom)
        backButton.frame = detailsButton.frame
        backButton.setImage(UIImage(named: "backbtn"), forState: .Normal)
        backButton.addTarget(self, action: Selector("hideDetails"), forControlEvents: .TouchUpInside)
        backView.addSubview(backButton)
        
        
    }
    
    func showDetails() {
        
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        var angle = CGFloat(M_PI)
        var rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)

        let rotation = CASpringAnimation(keyPath: "transform")
        rotation.damping = 1200
        rotation.stiffness = 430
        rotation.mass = 4
        rotation.initialVelocity = 16
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotation.fromValue = NSValue(CATransform3D: identity)
        rotation.toValue = NSValue(CATransform3D: rotationTransform)
        rotation.duration = rotation.settlingDuration
        frontView.layer.addAnimation(rotation, forKey: nil)
        

        identity.m34 = 1.0/1000
        angle = CGFloat(M_PI)
        rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        let rotationBack = CASpringAnimation(keyPath: "transform")
        rotationBack.damping = 1200
        rotationBack.stiffness = 430
        rotationBack.mass = 4
        rotationBack.initialVelocity = 16
        rotationBack.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotationBack.fromValue = NSValue(CATransform3D: rotationTransform)
        rotationBack.toValue = NSValue(CATransform3D: identity)
        rotationBack.duration = rotationBack.settlingDuration
        backView.layer.addAnimation(rotationBack, forKey: nil)
        backView.layer.transform = identity
        
        UIView.animateWithDuration(0.05, delay: 0.1, options: .CurveEaseIn, animations: { () -> Void in
            self.frontView.alpha = 0
            }) {_ -> Void in
                
        }
        
        delay(seconds: 0.1) { () -> () in
            self.insertSubview(self.frontView, belowSubview: self.backView)
            self.backView.alpha = 1

        }
        
    }
    
    func hideDetails() {
        var identity = CATransform3DIdentity
        identity.m34 = 1.0/1000
        var angle = CGFloat(M_PI)
        var rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        
        let rotation = CASpringAnimation(keyPath: "transform")
        rotation.damping = 1200
        rotation.stiffness = 430
        rotation.mass = 4
        rotation.initialVelocity = 16
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotation.fromValue = NSValue(CATransform3D: identity)
        rotation.toValue = NSValue(CATransform3D: rotationTransform)
        rotation.duration = rotation.settlingDuration
        backView.layer.addAnimation(rotation, forKey: nil)
        
        
        identity.m34 = -1.0/1000
        angle = CGFloat(M_PI)
        rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        let rotationBack = CASpringAnimation(keyPath: "transform")
        rotationBack.damping = 1200
        rotationBack.stiffness = 430
        rotationBack.mass = 4
        rotationBack.initialVelocity = 16
        rotationBack.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotationBack.fromValue = NSValue(CATransform3D: rotationTransform)
        rotationBack.toValue = NSValue(CATransform3D: identity)
        rotationBack.duration = rotationBack.settlingDuration
        frontView.layer.addAnimation(rotationBack, forKey: nil)
        frontView.layer.transform = identity
        
        UIView.animateWithDuration(0.05, delay: 0.1, options: .CurveEaseIn, animations: { () -> Void in
            self.backView.alpha = 0
            }) {_ -> Void in

        }
        
        delay(seconds: 0.1) { () -> () in
            self.insertSubview(self.backView, belowSubview: self.frontView)
            self.frontView.alpha = 1
            
        }
    }

}
