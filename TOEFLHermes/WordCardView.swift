//
//  WordCardView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/2.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

enum ChangeCard: Int {
    case Previous = 0, Next
}

protocol WordCardViewDelegate {
    func loadPreviousWord()
    func loadNextWord()
}

class WordCardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    static let aspectRatio: CGFloat = 1.425
    var middleCardImage: UIImageView!
    var cardImage: UIImageView!
    var coverImage: UIImageView!
    var backCardImage: UIImageView!
    var detailCardImage: UIImageView!
    private var currentCoverYOffset: CGFloat = 0.0
    private var progress: CGFloat = 0
    var changeCard: ChangeCard!
    private var frontRect: CGRect!
    private var middleRect: CGRect!
    private var backRect: CGRect!
    private var pullDownRect: CGRect!
    
    static func calcHeigthWithWidth(width: CGFloat) -> CGFloat {
        return width * WordCardView.aspectRatio
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews () {
        cardImage = UIImageView(image: UIImage(named: "wordcard"))
        cardImage.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        middleRect = cardImage.frame
        cardImage.userInteractionEnabled = true
        cardImage.alpha = 1
        cardImage.contentMode = .ScaleAspectFill
        cardImage.layer.shouldRasterize = false
        cardImage.layer.rasterizationScale = UIScreen.mainScreen().scale
        frontRect = cardImage.frame
        
        detailCardImage = UIImageView(image: UIImage(named: "wordcardback"))
        detailCardImage.frame = frontRect
        detailCardImage.contentMode = .ScaleAspectFill
        detailCardImage.layer.shouldRasterize = false
        detailCardImage.layer.rasterizationScale = UIScreen.mainScreen().scale
        detailCardImage.alpha = 0
        detailCardImage.userInteractionEnabled = true
        
        // add back button to detailscard
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: 20 * scaleFactor, y: 20 * scaleFactor, width: 15 * scaleFactor, height: 10 * scaleFactor)
        backButton.setImage(UIImage(named: "wordcardbackbtn"), forState: .Normal)
        backButton.addTarget(self, action: Selector("rotateBack"), forControlEvents: .TouchUpInside)
        detailCardImage.addSubview(backButton)
        
        
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        let angle = CGFloat(-M_PI/2)
        let rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        detailCardImage.layer.transform = rotationTransform

        
        middleCardImage = UIImageView(image: UIImage(named: "wordcard"))
        middleCardImage.frame = CGRect(x: 0, y: 0, width: bounds.width * 0.95, height: bounds.height * 0.95)
        middleCardImage.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - bounds.height * 0.05)
        middleCardImage.contentMode = .ScaleAspectFill
        middleCardImage.alpha = 0.5
        middleRect = middleCardImage.frame
        
        backCardImage = UIImageView(image: UIImage(named: "wordcard"))
        backCardImage.frame = CGRect(x: 0, y: 0, width: bounds.width * 0.9, height: bounds.width * 0.9)
        backCardImage.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - bounds.height * 0.1)
        backCardImage.contentMode = .ScaleAspectFill
        backCardImage.alpha = 0.3
        backRect = backCardImage.frame
        
        pullDownRect = cardImage.frame.offsetBy(dx: 0, dy: -self.frame.height / 2)
        
        addSubview(backCardImage)
        addSubview(middleCardImage)
        addSubview(detailCardImage)
        addSubview(cardImage)
        
        coverImage = UIImageView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        coverImage.contentMode = .ScaleAspectFill
        addSubview(coverImage)
        coverImage.alpha = 0
        
        // add pan gesture
        currentCoverYOffset = self.frame.height / 2
        let pan = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        cardImage.addGestureRecognizer(pan)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
        longPress.minimumPressDuration = 0.3
        cardImage.addGestureRecognizer(longPress)
        
    }
    
    func resetCardViews() {
        self.coverImage.frame = frontRect
        self.coverImage.alpha = 0
        self.cardImage.alpha = 1
        self.cardImage.frame = self.frontRect
        self.middleCardImage.frame = self.middleRect
        self.middleCardImage.alpha = 0.5
        self.backCardImage.frame = self.backRect
        self.backCardImage.alpha = 0.3
    }
    
    func loadPreviousWord() {
        //
    }
    
    func loadCurrentWord() {
        
    }
    
    func loadNextWord() {
        
    }
    
    
    func refreshCoverImage() {
        let currentAlpha = cardImage.alpha
        cardImage.alpha = 1
        UIGraphicsBeginImageContextWithOptions(cardImage.bounds.size, false, UIScreen.mainScreen().scale)
        cardImage.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newCover = UIGraphicsGetImageFromCurrentImageContext()
        coverImage.image = newCover
        UIGraphicsEndImageContext()
        cardImage.alpha = currentAlpha
        coverImage.alpha = 1
        
    }
    
    func rotateCardImage() {
        
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        let angle = CGFloat(M_PI/2)
        let rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        
        UIView.animateKeyframesWithDuration(1.4, delay: 0, options: [], animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.12, animations: { () -> Void in
                self.middleCardImage.frame.origin.y = self.middleRect.origin.y + 15
                self.backCardImage.frame.origin.y = self.backRect.origin.y + 15
            })
            UIView.addKeyframeWithRelativeStartTime(0.12, relativeDuration: 0.01, animations: { () -> Void in
                self.middleCardImage.alpha = 0
                self.backCardImage.alpha = 0
            })
            UIView.addKeyframeWithRelativeStartTime(0.13, relativeDuration: 0.5, animations: { () -> Void in
                self.cardImage.layer.transform = rotationTransform
            })
            UIView.addKeyframeWithRelativeStartTime(0.63, relativeDuration: 0.01, animations: { () -> Void in
                self.detailCardImage.alpha = 1
                self.cardImage.alpha = 0
            })
            UIView.addKeyframeWithRelativeStartTime(0.64, relativeDuration: 0.5, animations: { () -> Void in
                self.detailCardImage.layer.transform = identity
            })
            }) {_ in
                
        }
        

        
    }
    
    func rotateBack() {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        let angle = CGFloat(-M_PI/2)
        let rotationTransform = CATransform3DRotate(identity, angle, 0, 1, 0)
        
        UIView.animateKeyframesWithDuration(1.2, delay: 0, options: [], animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { () -> Void in
                self.detailCardImage.layer.transform = rotationTransform
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.01, animations: { () -> Void in
                self.detailCardImage.alpha = 0
                self.cardImage.alpha = 1
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.5, animations: { () -> Void in
                self.cardImage.layer.transform = identity
            })
            
            
            }) {_ in
                UIView.animateWithDuration(0.33, animations: { () -> Void in
                    self.middleCardImage.alpha = 0.5
                    self.backCardImage.alpha = 0.3
                    self.middleCardImage.frame.origin.y = self.middleRect.origin.y
                    self.backCardImage.frame.origin.y = self.backRect.origin.y
                })
        }
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        switch recognizer.state {
        case .Began:
            if (translation.y < 0) {
                changeCard = ChangeCard.Next
                refreshCoverImage()
                cardImage.frame = middleRect
                cardImage.alpha = 0.5
                middleCardImage.frame = backRect
                middleCardImage.alpha = 0.3
                backCardImage.frame.origin.y = self.backRect.origin.y + 10
                backCardImage.alpha = 0
            } else {
                changeCard = ChangeCard.Previous
                refreshCoverImage()
                coverImage.frame = pullDownRect
                coverImage.alpha = 0
            }
        case .Changed:
            var offset: CGFloat = 0
            if (changeCard.rawValue == 0) {
                offset = min(translation.y, self.frame.height / 2)
                progress = offset / (self.frame.height / 2)
                coverImage.alpha = progress
                coverImage.center.y = offset
            } else {
                offset = min(translation.y, 0)
                progress = offset / (screenHeight / 2.5) * -1
                cardImage.alpha = cardImage.alpha + progress
                coverImage.center.y = currentCoverYOffset + offset
                if (offset == 0) {
                    self.cardImage.alpha = 0.5
                }
            }
            
        case .Ended: fallthrough
        case .Cancelled: fallthrough
        case .Failed:
            currentCoverYOffset = cardImage.center.y
            if (currentCoverYOffset - self.frame.height / 2 < 0) {
                if (progress < 0.5) {
                    UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.coverImage.center.y = self.frame.height / 2
                        self.currentCoverYOffset = self.frame.height / 2
                        self.cardImage.alpha = 0.5
                        }, completion: {_ in
                            self.resetCardViews()
                    })
                } else {
                    UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.coverImage.center.y = -self.frame.height / 2
                        self.coverImage.alpha = 0
                        self.currentCoverYOffset = self.frame.height / 2
                        }, completion: nil)
                    UIView.animateWithDuration(0.33, delay: 0.15, options: .CurveEaseOut, animations: { () -> Void in
                        self.cardImage.frame = self.frontRect
                        self.cardImage.alpha = 1
                        }, completion: nil)
                    UIView.animateWithDuration(0.25, delay: 0.25, options: .CurveEaseOut, animations: { () -> Void in
                        self.middleCardImage.frame = self.middleRect
                        self.middleCardImage.alpha = 0.5
                        }, completion: {_ in
                            self.refreshCoverImage()
                            self.coverImage.frame = self.frontRect
                            self.coverImage.alpha = 0
                            UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                                self.backCardImage.frame.origin.y = self.backRect.origin.y
                                self.backCardImage.alpha = 0.3
                                }, completion: nil)
                    })
                    
                }
            } else {
                if (progress < 0.5) {
                    UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.coverImage.frame = self.pullDownRect
                        self.coverImage.alpha = 0
                        }, completion: {_ in
                            self.resetCardViews()
                    })
                } else {
                    UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.coverImage.center.y = self.frame.height / 2
                        self.coverImage.alpha = 1
                        }, completion: nil)
                    UIView.animateWithDuration(0.15, delay: 0.1, options: .CurveEaseOut, animations: { () -> Void in
                        self.backCardImage.alpha = 0
                        self.backCardImage.frame.origin.y = self.backRect.origin.y
                        }, completion: nil)
                    UIView.animateWithDuration(0.3, delay: 0.15, options: .CurveEaseOut, animations: { () -> Void in
                        self.middleCardImage.frame = self.backRect
                        self.middleCardImage.alpha = 0.3
                        }, completion: nil)
                    UIView.animateWithDuration(0.3, delay: 0.22, options: .CurveEaseOut, animations: { () -> Void in
                        self.cardImage.frame = self.middleRect
                        self.cardImage.alpha = 0.5
                        }, completion: {_ in
                            self.resetCardViews()
                    })
                }
            }
            
        default: break
        }
    }
    
    func handleLongPress(recognizer: UIGestureRecognizer) {
        rotateCardImage()
        
    }

}
