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
  @IBOutlet weak var textView: UITextView!
  
  var kaomoji: Kaomoji?{
    didSet{
      if let kaomoji = kaomoji{
        label.text = kaomoji.text
//        textView.text = kaomoji.text
        showHideFavoriteView()
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func prepareForReuse(){
    super.prepareForReuse()
    label.text = nil
    println("reuse")
  }
  
  func loadView()
  {
    var longPress = UILongPressGestureRecognizer(target: self, action: Selector.convertFromStringLiteral("longPress:"))
    self.addGestureRecognizer(longPress)
  }
  
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
