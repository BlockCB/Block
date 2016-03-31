//
//  Uitils.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/29.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import Foundation
import UIKit

let scaleFactor:CGFloat = UIScreen.mainScreen().bounds.width / 320.0
let screenWidth:CGFloat = UIScreen.mainScreen().bounds.width
let screenHeight:CGFloat = UIScreen.mainScreen().bounds.height
let middleScreenHori:CGFloat =  screenWidth / 2
let middleScreenVerti:CGFloat = screenHeight / 2
let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

let sampleTask3BackColor = UIColor(red: 136/255.0, green: 175/255.0, blue: 195/255.0, alpha: 1)
let sampleTask4BackColor = UIColor(red: 252/255.0, green: 191/255.0, blue: 111/255.0, alpha: 1)
let sampleTask5BackColor = UIColor(red: 238/255.0, green: 110/255.0, blue: 86/255.0, alpha: 1)
let sampleTask6BackColor = UIColor(red: 216/255.0, green: 65/255.0, blue: 49/255.0, alpha: 1)


let clearColor = UIColor.clearColor()
let naviColor = UIColor(red: 244/255.0, green: 238/255.0, blue: 230/255.0, alpha: 1)

let sampleTaskCellHeight:CGFloat = 90

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

func colorWithRGB(red red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
}

func getDeviceType() -> String {
    if scaleFactor > 1.17 && scaleFactor < 1.2 {
        return "iphone6s"
    } else if scaleFactor > 1.2 {
        return "iphone6ps"
    }
    return "iphone5s"
}

extension UIImage {
    class func colorImage(color: UIColor) -> UIImage {
        return self.colorImage(color, size: CGSize(width: 2, height: 2))
    }
    
    class func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), CGBlendMode.XOR)
        let cgImage = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext())
        UIGraphicsEndImageContext()
        return UIImage(CGImage: cgImage!).stretchableImageWithLeftCapWidth(1, topCapHeight: 1)
    }}

