//
//  FirstViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class SampleTopViewController: BaseViewController {
    
    private var pieceViewHeight:CGFloat = 0.0
    let task3View = UIView(frame: CGRectZero)
    let task4View = UIView(frame: CGRectZero)
    let task5View = UIView(frame: CGRectZero)
    let task6View = UIView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navi.titleLabel.text = "综合范文"
//        tabBarController?.tabBarItem.selectedImage = UIImage(named: "tabOneSel")?.imageWithRenderingMode(.AlwaysOriginal)
//        tabBarController?.tabBar.tintColor = UIColor.orangeColor()
//        tabBarItem!.selectedImage = UIImage(named: "tabOneSel")?.imageWithRenderingMode(.AlwaysOriginal)


        
        pieceViewHeight = visibleHeight / 4
        // set task3view
        task3View.frame = CGRect(x: 0, y: CGRectGetMaxY(navigationController!.navigationBar.frame), width: screenWidth, height: pieceViewHeight)
        task3View.backgroundColor = sampleTask3BackColor
        let task3ImgView = UIImageView(frame: task3View.frame)
        task3ImgView.center = CGPoint(x: screenWidth/2, y: 3 + pieceViewHeight / 2)
        task3ImgView.image = UIImage(named: "task3sampleimg")
        task3ImgView.userInteractionEnabled = true
        task3ImgView.tag = 3
        let tapTask3 = UITapGestureRecognizer(target: self, action: Selector("tapHandler:"))
        task3ImgView.addGestureRecognizer(tapTask3)
        task3View.addSubview(task3ImgView)
        
        
        // set task4view
        task4View.frame = CGRect(x: 0, y: CGRectGetMaxY(task3View.frame), width: screenWidth, height: pieceViewHeight)
        task4View.backgroundColor = sampleTask4BackColor
        let task4ImgView = UIImageView(frame: task4View.frame)
        task4ImgView.center = CGPoint(x: screenWidth/2, y: 3 + pieceViewHeight / 2)
        task4ImgView.image = UIImage(named: "task4sampleimg")
        task4ImgView.tag = 4
        task4ImgView.userInteractionEnabled = true
        let tapTask4 = UITapGestureRecognizer(target: self, action: Selector("tapHandler:"))
        task4ImgView.addGestureRecognizer(tapTask4)
        task4View.addSubview(task4ImgView)
        
        
        // set task5view
        task5View.frame = CGRect(x: 0, y: CGRectGetMaxY(task4View.frame), width: screenWidth, height: pieceViewHeight)
        task5View.backgroundColor = sampleTask5BackColor
        let task5ImgView = UIImageView(frame: task5View.frame)
        task5ImgView.center = CGPoint(x: screenWidth/2, y: 5 + pieceViewHeight / 2)
        task5ImgView.image = UIImage(named: "task5sampleimg")
        task5ImgView.tag = 5
        task5ImgView.userInteractionEnabled = true
        let tapTask5 = UITapGestureRecognizer(target: self, action: Selector("tapHandler:"))
        task5ImgView.addGestureRecognizer(tapTask5)
        task5View.addSubview(task5ImgView)
        
        
        // set task6view
        task6View.frame = CGRect(x: 0, y: CGRectGetMaxY(task5View.frame), width: screenWidth, height: pieceViewHeight)
        task6View.backgroundColor = sampleTask6BackColor
        let task6ImgView = UIImageView(frame: task6View.frame)
        task6ImgView.center = CGPoint(x: screenWidth/2, y: pieceViewHeight / 2)
        task6ImgView.image = UIImage(named: "task6sampleimg")
        task6ImgView.tag = 6
        task6ImgView.userInteractionEnabled = true
        let tapTask6 = UITapGestureRecognizer(target: self, action: Selector("tapHandler:"))
        task6ImgView.addGestureRecognizer(tapTask6)
        task6View.addSubview(task6ImgView)
        
        // add all sub views
        view.addSubview(task6View)
        view.addSubview(task5View)
        view.addSubview(task4View)
        view.addSubview(task3View)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // push loginVC
//        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let loginVC = storyBoard.instantiateViewControllerWithIdentifier("login")
//        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // customized funcs
    func tapHandler(recognizer: UITapGestureRecognizer) {
        let sampleTaskVC = storyBoard.instantiateViewControllerWithIdentifier("samplelist") as! SampleTaskListViewController
        sampleTaskVC.taskNum = recognizer.view!.tag
        navigationController?.pushViewController(sampleTaskVC, animated: true)
    }
    
//    func pushSampleTasKVC(taskNum: Int) {
//        let sampleTaskVC = SampleTaskListViewController()
//        sampleTaskVC.taskNum = taskNum
//        navigationController?.pushViewController(sampleTaskVC, animated: true)
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

