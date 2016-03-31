//
//  BaseViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/31.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var visibleHeight:CGFloat = 0
    var leftBarBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = naviColor
        
      
        leftBarBtn = UIButton(type: .Custom)
        leftBarBtn.frame = CGRect(x: 0, y: 0, width: 15 * scaleFactor, height: 15 * scaleFactor)
        leftBarBtn.setImage(UIImage(named: "navimenu"), forState: .Normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarBtn)
        
        if let tabHeight = tabBarController?.tabBar.frame.height {
            visibleHeight = screenHeight - tabHeight - CGRectGetMaxY(navigationController!.navigationBar.frame)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // push loginVC
//                let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//                let loginVC = storyBoard.instantiateViewControllerWithIdentifier("login")
//                presentViewController(loginVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.navigationBarHidden = true
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
