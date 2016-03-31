//
//  TopNavigationView.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/1/30.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class TopNavigationView: UIView {

    var titleLabel = UILabel()
    var leftButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 11.5)
        backgroundColor = UIColor(red: 244/255.0, green: 238/255.0, blue: 230/255.0, alpha: 1)
        
        let topOffset = 12 * scaleFactor
        
        // init title label
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.frame = CGRect(x: 0, y: topOffset, width: screenWidth, height: self.frame.height - topOffset)
        titleLabel.font = UIFont.systemFontOfSize(13*scaleFactor)
        titleLabel.textAlignment = .Center
        addSubview(titleLabel)
        // init left menu button
        leftButton = UIButton(type: .Custom)
        let sideLength = 15 * scaleFactor
        
        leftButton.frame = CGRect(x: topOffset, y: topOffset + (self.frame.height - topOffset - sideLength) / 2, width: sideLength, height: sideLength)
        leftButton.setImage(UIImage(named: "navimenu"), forState: .Normal)
        addSubview(leftButton)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
