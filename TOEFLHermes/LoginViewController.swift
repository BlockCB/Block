//
//  LoginViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("dismissLogin"))
        view.addGestureRecognizer(tap)
    }
    
    func dismissLogin() {
        dismissViewControllerAnimated(true) {_ in
            
        }
    }

}
