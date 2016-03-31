//
//  LexiconTopViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

enum LexiconCardPositionStatus: Int {
    case FrontCardIsFirstCard = 0, FrontCardIsMiddleCard, FrontCardIsBackCard
}

class LexiconTopViewController: BaseViewController {
    
    let cardWidth: CGFloat = 260 * scaleFactor
    var lexiconCard = LexiconCardView()
    var middleCard = LexiconCardView()
    var backCard = LexiconCardView()
    var preCard = LexiconCardView()
    var currentOperatedCard: LexiconCardView!
    var currentMiddleCard: LexiconCardView!
    var currentBackCard: LexiconCardView!
    var cardPositionStatus: LexiconCardPositionStatus!
    
    var yOffset = -17 * scaleFactor
    var originalFrontRect: CGRect!
    var frontCardYoffset: CGFloat!
    var middleCardYoffset: CGFloat!
    var backCardYoffset: CGFloat!
    var currentCoverYOffset: CGFloat!
    var currentYOffsetPre: CGFloat!
    var progress: CGFloat = 0
    var showingNextWord: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCards()
        initSwipeView()
        
//        initFoldingView()
        
    }
    
    func initCards () {
        cardPositionStatus = LexiconCardPositionStatus.FrontCardIsFirstCard
        
        lexiconCard = LexiconCardView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: LexiconCardView.calcHeigthWithWidth(cardWidth)))
        lexiconCard.cardColor = sampleTask5BackColor
        lexiconCard.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        lexiconCard.wordLabel.text = "Dream"
        currentCoverYOffset = lexiconCard.center.y
        view.addSubview(lexiconCard)
        frontCardYoffset = lexiconCard.center.y
        originalFrontRect = lexiconCard.frame
        
        currentOperatedCard = lexiconCard

        
        middleCard = LexiconCardView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: LexiconCardView.calcHeigthWithWidth(cardWidth)))
        middleCard.cardColor = sampleTask5BackColor
        middleCard.center = CGPoint(x: screenWidth / 2, y: lexiconCard.center.y + yOffset)
        middleCard.alpha = 0.8
        middleCard.wordLabel.text = "Friend"
        view.insertSubview(middleCard, belowSubview: lexiconCard)
        middleCardYoffset = middleCard.center.y
        middleCard.transform = CGAffineTransformMakeScale(0.95, 0.95)
        
        currentMiddleCard = middleCard

        
        backCard = LexiconCardView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: LexiconCardView.calcHeigthWithWidth(cardWidth)))
        backCard.cardColor = sampleTask5BackColor
        backCard.center = CGPoint(x: screenWidth / 2, y: middleCard.center.y + yOffset)
        backCard.alpha = 0.5
        backCard.wordLabel.text = "Smile"
        view.insertSubview(backCard, belowSubview: middleCard)
        backCardYoffset = backCard.center.y
        backCard.transform = CGAffineTransformMakeScale(0.9, 0.9)
        
        currentBackCard = backCard
        
        resignPanGesture()
        
        
    }
    
    func resignPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        currentOperatedCard.addGestureRecognizer(pan)
    }
    
    func initSwipeView() {
        let swipeView = UIView(frame: CGRect(x: 0, y: CGRectGetMinY(tabBarController!.tabBar.frame) - 50*scaleFactor, width: screenWidth, height: 50*scaleFactor))
        swipeView.backgroundColor = UIColor.greenColor()
        view.addSubview(swipeView)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        swipeView.addGestureRecognizer(swipeRight)
        swipeView.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.Left:
            print("left")
            switchLib()
        case UISwipeGestureRecognizerDirection.Right:
            print("right")
            switchLib()
        default:
            break
        }
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        switch recognizer.state {
        case .Began:
            if translation.y <= 0 {
                preCard = LexiconCardView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: LexiconCardView.calcHeigthWithWidth(cardWidth)))
                preCard.cardColor = sampleTask5BackColor
                preCard.center = CGPoint(x: screenWidth / 2, y: screenHeight * 3 / 2)
                UIView.animateWithDuration(0.15, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    self.preCard.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2 + 200 * scaleFactor)
                    }, completion: nil)
                UIView.animateWithDuration(0.66, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
                    self.currentBackCard.center.y -= 2 * self.yOffset
                    self.currentBackCard.alpha = 0
                    }, completion: nil)
                currentYOffsetPre = preCard.center.y
                view.addSubview(preCard)
                showingNextWord = false
            } else {
                showingNextWord = true
            }
        case .Changed:
            if translation.y > 0 && showingNextWord == true {
                var offset: CGFloat = 0
                offset = min(translation.y, currentCoverYOffset)
                currentOperatedCard.center.y = currentCoverYOffset + offset
                progress = offset / (screenHeight / 2.5)
            }
            if translation.y < 0 {
                var offset: CGFloat = 0
                offset = min(max(translation.y, currentCoverYOffset - currentYOffsetPre), 0)
                preCard.center.y = currentYOffsetPre + offset
                progress = offset / (screenHeight / 4) * -1
                if progress <= 0.6 && progress >= 0.1 {
                    let percent = (progress - 0.1) / 0.5
                    currentOperatedCard.center.y = frontCardYoffset - (frontCardYoffset - middleCardYoffset) * percent/2
                    currentOperatedCard.alpha = 1 - 0.2 * percent/2
                    currentOperatedCard.transform = CGAffineTransformMakeScale(1 - 0.05 * percent/2, 1 - 0.05 * percent/2)
                    currentMiddleCard.center.y = middleCardYoffset - (middleCardYoffset - backCardYoffset) * percent/2
                    currentMiddleCard.alpha = 0.8 - 0.3 * percent/2
                    currentMiddleCard.transform = CGAffineTransformMakeScale(0.95 - 0.05 * percent/2, 0.95 - 0.05 * percent/2)
                }
            }
        case .Failed: fallthrough
        case .Cancelled: fallthrough
        case .Ended:
            if showingNextWord == true {
                if progress < 0.5 {
                    UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.currentOperatedCard.frame = self.originalFrontRect
                        }, completion: nil)
                } else {
                    showNextCardwithStatus(cardPositionStatus)
                    
                }
            } else {
                if progress < 0.6 {
                    UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                        self.preCard.center.y = screenHeight * 3/2
                        }, completion: {_ -> Void in
                            self.preCard.removeFromSuperview()
                    })
                    UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
                        self.currentBackCard.center.y = self.backCardYoffset
                        self.currentBackCard.alpha = 0.5
                        self.currentOperatedCard.center.y = self.frontCardYoffset
                        self.currentOperatedCard.alpha = 1
                        self.currentOperatedCard.transform = CGAffineTransformIdentity
                        self.currentMiddleCard.center.y = self.middleCardYoffset
                        self.currentMiddleCard.alpha = 0.8
                        self.currentMiddleCard.transform = CGAffineTransformMakeScale(0.95, 0.95)
                        }, completion: nil)
                } else {
                    UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
                        self.preCard.center.y = self.frontCardYoffset
                        }, completion: {_ -> Void in
                            self.showPreviousCardwithStatus(self.cardPositionStatus)
                    })
                }
            }
            progress = 0
            
        default:
            break
        }
        
    }
    
    func showNextCardwithStatus(status: LexiconCardPositionStatus) {
        switch status {
        case .FrontCardIsFirstCard:
            regulatingCardsToShowNextWord(lexiconCard, middleCard: middleCard, backCard: backCard)
            cardPositionStatus = LexiconCardPositionStatus.FrontCardIsMiddleCard
            
        case .FrontCardIsMiddleCard:
            regulatingCardsToShowNextWord(middleCard, middleCard: backCard, backCard: lexiconCard)
            cardPositionStatus = LexiconCardPositionStatus.FrontCardIsBackCard
        case .FrontCardIsBackCard:
            regulatingCardsToShowNextWord(backCard, middleCard: lexiconCard, backCard: middleCard)
            cardPositionStatus = LexiconCardPositionStatus.FrontCardIsFirstCard
        }
    }
    
    func regulatingCardsToShowNextWord(frontCard: LexiconCardView, middleCard: LexiconCardView, backCard: LexiconCardView) {
        self.view.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { () -> Void in
            frontCard.center.y = self.view.frame.height * 3/2
            frontCard.alpha = 0
            }, completion: {_ -> Void in
                frontCard.removeFromSuperview()
                self.view.insertSubview(frontCard, belowSubview: backCard)
                frontCard.center.y = self.backCardYoffset - 2 * self.yOffset
                frontCard.transform = CGAffineTransformMakeScale(0.9, 0.9)
                
                frontCard.alpha = 0.5
                UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
                    frontCard.center.y = self.backCardYoffset
                    }, completion: {_ -> Void in
                        self.currentOperatedCard = middleCard
                        self.currentMiddleCard = backCard
                        self.currentBackCard = frontCard
                        self.view.userInteractionEnabled = true
                        
                        self.resignPanGesture()
                })
                
        })
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            middleCard.center.y = self.frontCardYoffset
            middleCard.transform = CGAffineTransformIdentity
            middleCard.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            backCard.center.y = self.middleCardYoffset
            backCard.transform = CGAffineTransformMakeScale(0.95, 0.95)
            backCard.alpha = 0.8
            }, completion: {_ -> Void in
                
        })
        
        
    }
    
    func showPreviousCardwithStatus(status: LexiconCardPositionStatus) {
        
        self.view.userInteractionEnabled = false
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in

            self.currentMiddleCard.center.y = self.backCardYoffset
            self.currentMiddleCard.alpha = 0.5
            self.currentMiddleCard.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }) {_ -> Void in
                
        }
        
        UIView.animateWithDuration(0.33, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.currentOperatedCard.center.y = self.middleCardYoffset
            self.currentOperatedCard.alpha = 0.8
            self.currentOperatedCard.transform = CGAffineTransformMakeScale(0.95, 0.95)

            }) {_ -> Void in
                self.view.userInteractionEnabled = true
                switch status {
                case .FrontCardIsFirstCard:
                    self.regulatingCardsForPreviousWord(frontCard: self.lexiconCard, middleCard: self.middleCard, backCard: self.backCard, preCard: self.preCard)
                    
                case .FrontCardIsMiddleCard:
                    self.regulatingCardsForPreviousWord(frontCard: self.middleCard, middleCard: self.backCard, backCard: self.lexiconCard, preCard: self.preCard)
                case .FrontCardIsBackCard:
                    self.regulatingCardsForPreviousWord(frontCard: self.backCard, middleCard: self.lexiconCard, backCard: self.middleCard, preCard: self.preCard)
                }
        }
        
        
    }
    
    func regulatingCardsForPreviousWord(frontCard frontCard: LexiconCardView, middleCard: LexiconCardView, backCard: LexiconCardView, preCard: LexiconCardView) {
        
        backCard.removeFromSuperview()
        
        currentOperatedCard = preCard
        currentMiddleCard = frontCard
        currentBackCard = middleCard
        
        self.lexiconCard = currentOperatedCard
        self.middleCard = currentMiddleCard
        self.backCard = currentBackCard
        
        cardPositionStatus = LexiconCardPositionStatus.FrontCardIsFirstCard
        
        self.resignPanGesture()
    }
    
    
    func switchLib() {
        UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
            self.currentBackCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-screenWidth, 0), CGAffineTransformMakeScale(0.7, 0.7))
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.05, options: .CurveEaseIn, animations: { () -> Void in
            self.currentMiddleCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-screenWidth, 0), CGAffineTransformMakeScale(0.7, 0.7))
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.1, options: .CurveEaseIn, animations: { () -> Void in
            self.currentOperatedCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-screenWidth, 0), CGAffineTransformMakeScale(0.7, 0.7))
            }, completion: {_ -> Void in
                self.currentBackCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, 0), CGAffineTransformMakeScale(0.9, 0.9))
                self.currentBackCard.center.y = self.currentOperatedCard.center.y
                self.currentBackCard.alpha = 0
                self.currentMiddleCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, 0), CGAffineTransformMakeScale(0.95, 0.95))
                self.currentMiddleCard.alpha = 0
                self.currentMiddleCard.center.y = self.currentOperatedCard.center.y
                self.currentOperatedCard.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(screenWidth, 0), CGAffineTransformMakeScale(0.6, 0.6))

                UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
                    self.currentOperatedCard.transform = CGAffineTransformIdentity
                    }, completion: {_ -> Void in
                        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                            self.currentMiddleCard.alpha = 0.8
                            self.currentBackCard.alpha = 0.5
                            self.currentBackCard.center.y = self.currentOperatedCard.center.y + 2 * self.yOffset
                            self.currentMiddleCard.center.y = self.currentOperatedCard.center.y + self.yOffset

                            }, completion: {_ -> Void in
                                
                        })

                })
                
            })
    }
    
    func initFoldingView() {
        let foldingStoryboard = UIStoryboard.init(name: "FoldingCell", bundle: nil)
        let foldingVC = foldingStoryboard.instantiateViewControllerWithIdentifier("MainTableViewController")
//        foldingVC.view.frame = self.view.frame
//        self.addChildViewController(foldingVC)
//        self.view.addSubview(foldingVC.view)
//        foldingVC.didMoveToParentViewController(self)
        self .presentViewController(foldingVC, animated: true, completion: nil)
        
        
    }

}
