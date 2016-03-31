//
//  RepeatingTopTableViewCell.swift
//  TOEFLHermes
//
//  Created by haoxuan li on 16/2/6.
//  Copyright © 2016年 PumpkinCat. All rights reserved.
//

import UIKit

class RepeatingTopTableViewCell: UITableViewCell {
    
    var backGroundImage = UIImageView()
    var title = UILabel()
    private let xOffset: CGFloat = 10 * scaleFactor
    private let yOffset: CGFloat = 10 * scaleFactor
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backGroundImage = UIImageView(frame: CGRectZero)
        contentView.addSubview(backGroundImage)
        
        title = UILabel(frame: CGRectZero)
        title.lineBreakMode = .ByWordWrapping
        title.textAlignment = .Justified
        title.numberOfLines = 2
        title.font = UIFont.systemFontOfSize(12 * scaleFactor)
        title.backgroundColor = UIColor.clearColor()
        title.textColor = UIColor.whiteColor()
        contentView.addSubview(title)
        
        initSubviews()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        backGroundImage.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70 * scaleFactor)
        backGroundImage.image = UIImage(named: "repeatingtopcellbg1")
        
        title.frame = CGRect(x: xOffset, y: yOffset, width: screenWidth - 2 * xOffset, height: 40 * scaleFactor)
        title.text = "Talk about the most important decision that you made in your life."
    }
    
    func transformCell() {
        UIView.animateWithDuration(0.12, delay: 0, options: [], animations: { () -> Void in
            self.backGroundImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: nil)
        UIView.animateWithDuration(0.12, delay: 0.12, options: [], animations: { () -> Void in
            self.backGroundImage.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }

}
