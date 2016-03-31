//
//  SampleTaskTableViewCell.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/26.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class SampleTaskTableViewCell: UITableViewCell {
    
    var icon = UIImageView()
    var title = UILabel()
    var headSet = UIImageView()
    var tpoNum = UILabel()
    var lastTime = UILabel()
    var bottomLine = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon = UIImageView(frame: CGRectZero)
        title = UILabel(frame: CGRectZero)
        title.font = UIFont.systemFontOfSize(12*scaleFactor)
        title.backgroundColor = UIColor.clearColor()
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        headSet = UIImageView(frame: CGRectZero)
        tpoNum = UILabel(frame: CGRectZero)
        tpoNum.font = UIFont.systemFontOfSize(14*scaleFactor)
        tpoNum.backgroundColor = UIColor.clearColor()
        tpoNum.textColor = UIColor.whiteColor()
        tpoNum.textAlignment = .Center
        lastTime = UILabel(frame: CGRectZero)
        lastTime.font = UIFont.systemFontOfSize(11*scaleFactor)
        lastTime.backgroundColor = UIColor.clearColor()
        lastTime.textColor = UIColor.whiteColor()
        bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(white: 1, alpha: 0.2)
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(headSet)
        contentView.addSubview(tpoNum)
        contentView.addSubview(lastTime)
        contentView.addSubview(bottomLine)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellContents() {
        icon.frame = CGRect(x: 0, y: 0, width: 26*scaleFactor, height: 26*scaleFactor)
        icon.center = CGPoint(x: middleScreenHori, y: sampleTaskCellHeight * scaleFactor / 4)
        
        tpoNum.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        tpoNum.text = "Tpo 1"
        tpoNum.center = CGPoint(x: middleScreenHori, y: sampleTaskCellHeight * scaleFactor / 2)
        
        headSet.frame = CGRect(x: 0, y: 0, width: 14*scaleFactor, height: 14*scaleFactor)
        headSet.center = CGPoint(x: middleScreenHori + 40 * scaleFactor, y: sampleTaskCellHeight * scaleFactor / 2)
        headSet.image = UIImage(named: "headsets")?.imageWithRenderingMode(.AlwaysOriginal)
        
        lastTime.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        lastTime.center = CGPoint(x: CGRectGetMaxX(headSet.frame) + 10 * scaleFactor + 25, y: headSet.center.y)
        lastTime.text = "1:38s"
        
        title.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
        title.center = CGPoint(x: middleScreenHori, y: sampleTaskCellHeight * scaleFactor * 3 / 4)
        title.text = "Letter in the Centerville College News"
        
        bottomLine.frame = CGRect(x: 0, y: sampleTaskCellHeight * scaleFactor - 1.5, width: screenWidth, height: 1.5)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
