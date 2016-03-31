//
//  RepeatingDetailViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/3/12.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit
import MXParallaxHeader

class RepeatingDetailViewController: UIViewController {
    
    var scrollView: MXScrollView!
    var textContent = UITextView()
    var naviCoverView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 18 * scaleFactor, height: 18 * scaleFactor)
        backButton.setImage(UIImage(named: "backbtn"), forState: .Normal)
        backButton.tintColor = UIColor.whiteColor()
        backButton.addTarget(self, action: Selector("popToRootVC"), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        initSubviews()
    }
    
    func popToRootVC() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        let clearImage = UIImage.colorImage(UIColor.clearColor())
        navigationController?.navigationBar.shadowImage = clearImage
        navigationController?.navigationBar.setBackgroundImage(clearImage, forBarMetrics: .Default)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        
        let defaultImage = UIImage.colorImage(UIColor.whiteColor())
        navigationController?.navigationBar.shadowImage = defaultImage
        navigationController?.navigationBar.setBackgroundImage(defaultImage, forBarMetrics: .Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubviews() {
        scrollView = MXScrollView()
        scrollView.backgroundColor = UIColor.whiteColor()
        let yOffset = navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.height
        scrollView.frame = CGRect(x: 0, y: -yOffset, width: screenWidth, height: screenHeight + yOffset)
        scrollView.contentSize = scrollView.frame.size
        view.addSubview(scrollView)
        
        
        self.scrollView.parallaxHeader.view = NSBundle.mainBundle().loadNibNamed("RocketHeader", owner: self, options: nil).first as? UIView
        self.scrollView.parallaxHeader.height = 300
        self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.scrollView.parallaxHeader.minimumHeight = yOffset
        scrollView.delegate = self
        
        //init textView
        textContent = UITextView(frame: CGRect(x: 25 , y: 0, width: screenWidth - 50, height: screenHeight - yOffset))
        textContent.font = UIFont(name: "GillSans-Light", size: 15*scaleFactor)
        textContent.textColor = UIColor.blackColor()
        textContent.editable = false
        textContent.selectable = false
        textContent.textAlignment = .Justified
        textContent.backgroundColor = UIColor.clearColor()
        textContent.showsHorizontalScrollIndicator = false
        textContent.showsVerticalScrollIndicator = false
        textContent.text = "Letter in the Centerville College News\n\nThe administration has plans to acquire a new sculpture for campus. We should all appase this plan. The university’s poor financial condition led it to increase the price for campus housing and tuition by 15% this past year. Surely then it is no financial position to purchase such an expensive sculpture. Moreover,just look at the sculpture:several 60-foot ling steel plates,jutting out of the earth at odd angles! It’s so large,it’ll take up all the green space in front of the campus center! This is public space that should be reserved for students to use. The administration has plans to acquire a new sculpture for campus. We should all appase this plan. The university’s poor financial condition led it to increase the price for campus housing and tuition by 15% this past year. Surely then it is no financial position to purchase such an expensive sculpture. Moreover,just look at the sculpture:several 60-foot ling steel plates,jutting out of the earth at odd angles! It’s so large,it’ll take up all the green space in front of the campus center! This is public space that should be reserved for students to use."
        scrollView.addSubview(textContent)
        
        naviCoverView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: yOffset))
        naviCoverView.backgroundColor = colorWithRGB(red: 96, green: 85, blue: 115)
        naviCoverView.alpha = 0
        view.addSubview(naviCoverView)
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

extension RepeatingDetailViewController: MXScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        NSLog("progress %f", scrollView.parallaxHeader.progress)
        naviCoverView.alpha = scrollView.parallaxHeader.progress / -0.7
    }
}

