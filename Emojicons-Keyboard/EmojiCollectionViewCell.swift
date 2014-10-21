//
//  EmojiCollectionViewCell.swift
//  Emojicons
//
//  Created by Andrew K. on 10/16/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit
import EmojiKit

class EmojiCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var favoriteImageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  var pressed = false
  
  var kaomoji: Kaomoji?{
    didSet{
      if let kaomoji = kaomoji{
        label.text = kaomoji.text
        showHideFavoriteView()
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    loadView()
  }
  
  override func prepareForReuse(){
    super.prepareForReuse()
    label.text = ""
  }
  
  func loadView()
  {
    var press = UILongPressGestureRecognizer(target: self, action: Selector("press:"))
    self.addGestureRecognizer(press)
  }
  
  func press(gesture: UILongPressGestureRecognizer){
    
    if gesture.state == UIGestureRecognizerState.Began{
      NSLog("minimum duration elapsed")
      pressed = true
      
      delay(0.3, closure: {
        if self.pressed{
          self.favoriteStateChanged()
          self.showHideFavoriteView()
          self.playBlumpAnimation()
        }
      })
      
    }else if gesture.state == UIGestureRecognizerState.Ended{
      pressed = false
    }
    
    if gesture.state == UIGestureRecognizerState.Ended{
      
    }
  }
  
  private func delay(delay:Double, closure:()->()) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
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
