//
//  EmojiCell.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/16/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit
import EmojiKit

class EmojiCell: UICollectionViewCell {
  
  var favoriteImageView = UIImageView(image: UIImage(named: "ribbon"))
  var label: UILabel = UILabel(frame: CGRectZero)
  var kaomoji: Kaomoji?{
    didSet{
      if let kaomoji = kaomoji{
//        label.text = kaomoji.text
//        showHideFavoriteView()
      }
    }
  }
  
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
    self.layer.masksToBounds = true
    
    self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.4)
    
    label.numberOfLines = 1
    label.adjustsFontSizeToFitWidth = true
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    label.textAlignment = NSTextAlignment.Center
    self.addSubview(label)
    
    //
    var longPress = UILongPressGestureRecognizer(target: self, action: Selector.convertFromStringLiteral("longPress:"))
    self.addGestureRecognizer(longPress)
    
    favoriteImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.addSubview(favoriteImageView)
    
    
    ///
    
    
    var viewsDict = ["label":label]
    
    var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[label]-2-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
    var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
    //
    var heightProportion = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.6, constant: 0.0)
    var widthProportion = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: favoriteImageView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0.0)
    var topMargin = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0.0)
    var rightMargin = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0.0)
    
    self.addConstraints([heightProportion,widthProportion,topMargin,rightMargin])
    //
    self.addConstraints(horizontalConstraints)
    self.addConstraints(verticalConstraints)
  }
  
  
//  override func layoutSubviews()
//  {
//    var viewsDict = ["label":label]
//    
//    var horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[label]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
//    var verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:viewsDict)
//    //
//    var heightProportion = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.6, constant: 0.0)
//    var widthProportion = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: favoriteImageView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0.0)
//    var topMargin = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0.0)
//    var rightMargin = NSLayoutConstraint(item: favoriteImageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0.0)
//    
//    self.addConstraints([heightProportion,widthProportion,topMargin,rightMargin])
//    //
//    self.addConstraints(horizontalConstraints)
//    self.addConstraints(verticalConstraints)
//  }
  
  func longPress(gesture: UILongPressGestureRecognizer){
    if gesture.state == UIGestureRecognizerState.Ended{
      favoriteStateChanged()
      showHideFavoriteView()
      playBlumpAnimation()
    }
  }
  
  func favoriteStateChanged(){
    var context = KaomojiCoreDataManager.sharedInstance.managedObjectContext
    kaomoji?.changeFavoriteState(context: context!)
  }
  
  func showHideFavoriteView(){
    if let kaomoji = kaomoji{
      favoriteImageView.hidden = !kaomoji.favorite
    }
  }
  
  func playBlumpAnimation(){
    favoriteImageView.transform = CGAffineTransformMakeScale(0.1, 0.1)
    
    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
      self.favoriteImageView.transform = CGAffineTransformMakeScale(1, 1)
      }, completion: nil)
  }
  
}
