//
//  SampleTaskListViewController.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/31.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class SampleTaskListViewController: UITableViewController {
    
    var cellBackgroundColor = UIColor()
    
    var taskNum: Int! {
        didSet {
            title = "Task \(taskNum)"
            switch taskNum {
            case 3:
                cellBackgroundColor = sampleTask3BackColor
                break
            case 4:
                cellBackgroundColor = sampleTask4BackColor
                break
            case 5:
                cellBackgroundColor = sampleTask5BackColor
                break
            case 6:
                cellBackgroundColor = sampleTask6BackColor
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        tableView.registerClass(SampleTaskTableViewCell.self, forCellReuseIdentifier: "sampleTaskCell")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sampleTaskCell", forIndexPath: indexPath) as! SampleTaskTableViewCell
//        cell.textLabel!.text = "time tells the truth"
//        cell.textLabel?.backgroundColor = clearColor
//        cell.textLabel!.font = UIFont.systemFontOfSize(13 * scaleFactor)
//        cell.imageView?.image = UIImage(named: "samplelistcellimg")
//        cell.detailTextLabel!.text = "TPO 2"
//        cell.detailTextLabel!.backgroundColor = clearColor
//        cell.detailTextLabel!.font = UIFont.systemFontOfSize(13 * scaleFactor)
        
//        if (indexPath.row % 2 == 0) {
//            cell.contentView.backgroundColor = colorWithRGB(red: 182, green: 211, blue: 210)
//        } else {
//            cell.contentView.backgroundColor = colorWithRGB(red: 220, green: 240, blue: 240)
//        }
        cell.contentView.backgroundColor = cellBackgroundColor
        cell.icon.image = UIImage(named: "samplecellicon1")?.imageWithRenderingMode(.AlwaysOriginal)
        cell.selectionStyle = .None
        cell.setCellContents()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return sampleTaskCellHeight * scaleFactor
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sampleDetailVC = storyboard!.instantiateViewControllerWithIdentifier("samplevcone") as! SampleDetailViewController
        sampleDetailVC.titleStr = "Task \(taskNum) - Tpo \(indexPath.row + 1)"
        navigationController?.pushViewController(sampleDetailVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}



