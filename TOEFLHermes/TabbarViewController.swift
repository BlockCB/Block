//
//  TabbarViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/26.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTabItemIcon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabItemIcon() {
        let item0 = tabBar.items![0]
        let item1 = tabBar.items![1]
        let item2 = tabBar.items![2]
        let item3 = tabBar.items![3]
        
        item0.image = UIImage(named: "tabOne")?.imageWithRenderingMode(.AlwaysOriginal)
        item0.selectedImage = UIImage(named: "tabOneSel")?.imageWithRenderingMode(.AlwaysOriginal)
        item0.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        item1.image = UIImage(named: "tabTwo")?.imageWithRenderingMode(.AlwaysOriginal)
        item1.selectedImage = UIImage(named: "tabTwoSel")?.imageWithRenderingMode(.AlwaysOriginal)
        item1.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        item2.image = UIImage(named: "tabThree")?.imageWithRenderingMode(.AlwaysOriginal)
        item2.selectedImage = UIImage(named: "tabThreeSel")?.imageWithRenderingMode(.AlwaysOriginal)
        item2.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        item3.image = UIImage(named: "tabFour")?.imageWithRenderingMode(.AlwaysOriginal)
        item3.selectedImage = UIImage(named: "tabFourSel")?.imageWithRenderingMode(.AlwaysOriginal)
        item3.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        
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
