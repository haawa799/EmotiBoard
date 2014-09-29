//
//  EmojiCell.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/16/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {

    var label: UILabel = UILabel(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        loadView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadView()
    {
        self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)

        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
//        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    
    override func layoutSubviews()
    {
        var viewsDict = ["label":label]
        
        var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[label]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
        var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
        
        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)
    }
    
}
