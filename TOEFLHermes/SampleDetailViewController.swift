//
//  SampleDetailViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/31.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class SampleDetailViewController: UIViewController {
    
    var titleStr: String!
    var naviView = UIView()
    var scrollView = UIScrollView()
    var readingCard = CardView()
    var listeningCard = CardView()
    var questionCard = CardView()
    var sampleCard = CardView()
    let inset = 15 * scaleFactor
    let cardHeight = 130 * scaleFactor
    let offsetWidth = 25 * scaleFactor
    let textViewOffsetX = 35 * scaleFactor
    
    var resetButton = UIButton()
    
    var textContent = UITextView()
    
    var playerView = RepeatingPlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = colorWithRGB(red: 61, green: 53, blue: 78)
        naviView = UIView(frame: CGRectZero)
        naviView.backgroundColor = colorWithRGB(red: 96, green: 85, blue: 115)
        let viewHeight = CGRectGetMaxY(navigationController!.navigationBar.frame)
        naviView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: viewHeight)
        view.addSubview(naviView);
        
        
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 18 * scaleFactor, height: 18 * scaleFactor)
        backButton.setImage(UIImage(named: "backbtn"), forState: .Normal)
        backButton.tintColor = UIColor.whiteColor()
        backButton.center = CGPoint(x: 10 * scaleFactor + 10 * scaleFactor, y: CGRectGetMidY(navigationController!.navigationBar.frame))
        view.addSubview(backButton)
        backButton.addTarget(self, action: Selector("popVC"), forControlEvents: .TouchUpInside)


        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        titleLabel.center = CGPoint(x: CGRectGetMidX(navigationController!.navigationBar.frame), y: CGRectGetMidY(navigationController!.navigationBar.frame))
        titleLabel.font = UIFont.systemFontOfSize(14*scaleFactor)
        titleLabel.text = titleStr
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        view.addSubview(titleLabel)
        
        resetButton = UIButton(type: .Custom)
        resetButton.setImage(UIImage(named: "resetbtn"), forState: .Normal)
        resetButton.frame = CGRect(x: 0, y: 0, width: 40 * scaleFactor, height: 40 * scaleFactor)
        resetButton.center = CGPoint(x: middleScreenHori, y: 70 * scaleFactor)
        self.resetButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        self.resetButton.alpha = 0
        resetButton.addTarget(self, action: Selector("resetCards"), forControlEvents: .TouchUpInside)
        
        // Do any additional setup after loading the view.
        
        initSubviews()
    }
    
    func initSubviews() {
        let visibleHeight = screenHeight - CGRectGetMaxY(navigationController!.navigationBar.frame)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: CGRectGetMaxY(naviView.frame), width: screenWidth, height: visibleHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 5 * inset + 4 * cardHeight)
        view.addSubview(scrollView)
        
        readingCard = CardView(frame: CGRect(x: offsetWidth, y: inset, width: screenWidth - 2 * offsetWidth, height: cardHeight))
        readingCard.backgroundColor = sampleTask3BackColor
        readingCard.icon.image = UIImage(named: "readingicon")
        scrollView.addSubview(readingCard)
        let tapReading = UITapGestureRecognizer(target: self, action: Selector("expandingReading"))
        readingCard.addGestureRecognizer(tapReading)
        
        listeningCard = CardView(frame: CGRect(x: offsetWidth, y: CGRectGetMaxY(readingCard.frame) + inset, width: screenWidth - 2 * offsetWidth, height: cardHeight))
        listeningCard.backgroundColor = sampleTask4BackColor
        listeningCard.icon.image = UIImage(named: "listeningicon")
        listeningCard.title.text = "听力部分"
        scrollView.addSubview(listeningCard)
        let tapListening = UITapGestureRecognizer(target: self, action: Selector("expandingListening"))
        listeningCard.addGestureRecognizer(tapListening)
        
        questionCard = CardView(frame: CGRect(x: offsetWidth, y: CGRectGetMaxY(listeningCard.frame) + inset, width: screenWidth - 2 * offsetWidth, height: cardHeight))
        questionCard.backgroundColor = sampleTask5BackColor
        questionCard.icon.image = UIImage(named: "questionicon")
        questionCard.title.text = "问题部分"
        scrollView.addSubview(questionCard)
        let tapQuestion = UITapGestureRecognizer(target: self, action: Selector("expandingQuestion"))
        questionCard.addGestureRecognizer(tapQuestion)
        
        sampleCard = CardView(frame: CGRect(x: offsetWidth, y: CGRectGetMaxY(questionCard.frame) + inset, width: screenWidth - 2 * offsetWidth, height: cardHeight))
        sampleCard.backgroundColor = sampleTask6BackColor
        sampleCard.icon.image = UIImage(named: "sampleicon")
        sampleCard.title.text = "范文部分"
        scrollView.addSubview(sampleCard)
        let tapSample = UITapGestureRecognizer(target: self, action: Selector("expandingSample"))
        sampleCard.addGestureRecognizer(tapSample)
        
        let deviceType = getDeviceType()
        var offsetY:CGFloat = 40.0
        if deviceType == "iphone6s" {
            offsetY = 38
        } else if deviceType == "iphone5s" {
            offsetY = 35
        }
        
        resetButton.center = CGPoint(x: middleScreenHori, y: inset + offsetY * scaleFactor)
        scrollView.addSubview(resetButton)
        
        //init textView
        textContent = UITextView(frame: CGRect(x: textViewOffsetX , y: screenHeight * 2.05 / 5, width: screenWidth - 2 * textViewOffsetX, height: screenHeight / 2))
        textContent.font = UIFont(name: "GillSans-Light", size: 13*scaleFactor)
        textContent.alpha = 0
        textContent.textColor = UIColor.whiteColor()
        textContent.editable = false
        textContent.textAlignment = .Justified
        textContent.backgroundColor = UIColor.clearColor()
        textContent.showsHorizontalScrollIndicator = false
        textContent.showsVerticalScrollIndicator = false
        view.addSubview(textContent)
        
//        playerView = AudioPlayerView(frame: CGRect(x: offsetWidth, y: scrollView.frame.height * 5 / 6, width: screenWidth - 2 * offsetWidth, height: scrollView.frame.height / 6))
        playerView = RepeatingPlayerView(frame: CGRect(x: 0, y: scrollView.frame.height * 7 / 8, width: screenWidth, height: scrollView.frame.height / 8))
        scrollView.addSubview(playerView)
        playerView.hidden = true

        
    }
    
    func expandingReading() {
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.listeningCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.questionCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.sampleCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        var delayTime = 0.3
        if scrollView.contentOffset.y > 0 {
            delayTime = 0.5
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        delay(seconds: delayTime) { () -> () in
            self.readingCard.expandingAnimation()
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.resetButton.transform = CGAffineTransformIdentity
                self.resetButton.alpha = 1
                self.readingCard.leftLine.strokeColor = colorWithRGB(red: 197, green: 236, blue: 253).CGColor
                self.readingCard.rightLine.strokeColor = colorWithRGB(red: 197, green: 236, blue: 253).CGColor
                }, completion: {_ in
                self.showContentsOfReadingCard()
            })
        }
        
    }
    
    func expandingListening() {
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.readingCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.questionCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.sampleCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        var delayTime = 0.3
        if scrollView.contentOffset.y > 0 {
            delayTime = 0.5
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        delay(seconds: delayTime) { () -> () in
            self.listeningCard.expandingAnimation()
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.resetButton.transform = CGAffineTransformIdentity
                self.resetButton.alpha = 1

                self.listeningCard.leftLine.strokeColor = colorWithRGB(red: 252, green: 222, blue: 182).CGColor
                self.listeningCard.rightLine.strokeColor = colorWithRGB(red: 252, green: 222, blue: 182).CGColor
                
                }, completion: nil)
            self.playerView.hidden = false

        }
    }
    
    func expandingQuestion() {
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.readingCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.listeningCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.sampleCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        var delayTime = 0.3
        if scrollView.contentOffset.y > 0 {
            delayTime = 0.5
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        delay(seconds: delayTime) { () -> () in
            self.questionCard.expandingAnimation()
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.resetButton.transform = CGAffineTransformIdentity
                self.resetButton.alpha = 1

                self.questionCard.leftLine.strokeColor = colorWithRGB(red: 255, green: 170, blue: 147).CGColor
                self.questionCard.rightLine.strokeColor = colorWithRGB(red: 255, green: 170, blue: 147).CGColor
                
                }, completion: nil)
            self.showContentsOfQuestionCard()
        }
    }
    
    func expandingSample() {
        UIView.animateWithDuration(0.33, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.readingCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.listeningCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.CurveEaseIn], animations: { () -> Void in
            self.questionCard.frame.origin.x = screenWidth + 20
            }, completion: nil)
        var delayTime = 0.3
        if scrollView.contentOffset.y > 0 {
            delayTime = 0.5
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        delay(seconds: delayTime) { () -> () in
            self.sampleCard.expandingAnimation()
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                self.resetButton.transform = CGAffineTransformIdentity
                self.resetButton.alpha = 1

                self.sampleCard.leftLine.strokeColor = colorWithRGB(red: 255, green: 129, blue: 108).CGColor
                self.sampleCard.rightLine.strokeColor = colorWithRGB(red: 255, green: 129, blue: 108).CGColor
                
                }, completion: nil)
            self.showContentsOfSampleCard()
            self.playerView.hidden = false

        }
    }
    
    func resetCards() {
        playerView.stopPlayer()
        hideContentOfReadingCard()
        hideContentOfQuestionCard()
        hideContentOfSampleCard()
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.resetButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            self.resetButton.alpha = 0
            self.playerView.hidden = true
            }, completion: nil)
        delay(seconds: 0.1) { () -> () in
            self.readingCard.resetAnimation()
        }
        delay(seconds: 0.2) { () -> () in
            self.listeningCard.resetAnimation()
        }
        delay(seconds: 0.3) { () -> () in
            self.questionCard.resetAnimation()
        }
        delay(seconds: 0.4) { () -> () in
            self.sampleCard.resetAnimation()
        }
        
    }
    
    func popVC() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
        navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark: show contents based on cards
    func showContentsOfReadingCard() {
        textContent.text = "Letter in the Centerville College News\n\nThe administration has plans to acquire a new sculpture for campus. We should all appase this plan. The university’s poor financial condition led it to increase the price for campus housing and tuition by 15% this past year. Surely then it is no financial position to purchase such an expensive sculpture. Moreover,just look at the sculpture:several 60-foot ling steel plates,jutting out of the earth at odd angles! It’s so large,it’ll take up all the green space in front of the campus center! This is public space that should be reserved for students to use. The administration has plans to acquire a new sculpture for campus. We should all appase this plan. The university’s poor financial condition led it to increase the price for campus housing and tuition by 15% this past year. Surely then it is no financial position to purchase such an expensive sculpture. Moreover,just look at the sculpture:several 60-foot ling steel plates,jutting out of the earth at odd angles! It’s so large,it’ll take up all the green space in front of the campus center! This is public space that should be reserved for students to use."
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 1
            self.textContent.frame.size = CGSize(width: screenWidth - 2 * self.textViewOffsetX, height: screenHeight / 1.8)
            

        }
    }
    
    func hideContentOfReadingCard() {
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 0
            
        }
    }
    
    func showContentsOfQuestionCard() {
        textContent.text = "Explain why the woman disagrees with the reasons expressed in the letter."
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 1
            
        }
    }
    
    func hideContentOfQuestionCard() {
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 0
            
        }
    }
    
    func showContentsOfSampleCard() {
        textContent.text = "The author of the letter is opposing the school’s plan of putting a new sculpture on campus, because it’s too expensive and it takes up too much public space. In the conversation, the woman disagrees with the opinion stated in the letter. First of all, the school isn’t spending any money toward the sculpture, a donor is paying the bill. She thinks it’s nice to have some art on campus. Second, she says that Paul is disagreeing with the plan for he and his friends are always playing soccer at where the sculpture will be. It’s inconvenient for him and his friends, that they’ll have to find somewhere else to play."
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 1
            self.textContent.frame.size = CGSize(width: screenWidth - 2 * self.textViewOffsetX, height: screenHeight / 2.3)

        }
    }
    
    func hideContentOfSampleCard() {
        UIView.animateWithDuration(0.33) { () -> Void in
            self.textContent.alpha = 0
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
