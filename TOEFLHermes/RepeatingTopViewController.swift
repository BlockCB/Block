//
//  SecondViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class RepeatingTopViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.separatorStyle = .None
        tableView.registerClass(RepeatingTopTableViewCell.self, forCellReuseIdentifier: "repeatingtopcell")
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repeatingtopcell", forIndexPath: indexPath) as! RepeatingTopTableViewCell
//        cell.accessoryType = .None
//        cell.textLabel!.text = packItems[indexPath.row]
//        cell.imageView!.image = UIImage(named: "summericons_100px_0\(indexPath.row).png")
        let index = indexPath.row % 6 + 1
        cell.backGroundImage.image = UIImage(named: "repeatingtopcellbg\(index)")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70 * scaleFactor
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let details = RepeatingDetailViewController()
        details.hidesBottomBarWhenPushed = true
        
//        let backBtn = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem = backBtn
//        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
//        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        
        navigationController!.pushViewController(details, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


