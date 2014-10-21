//
//  EmojiFlowLayout.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/15/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit

class EmojiFlowLayout: UICollectionViewFlowLayout {
  
  var optimalWidth:Float = 0.0
  
  var optimalHeight:Float = 0.0
  
  let minLineSpace:Float = 1.0
  let minItemSpace:Float = 1.0
  
  
  var columns = 0
  var rows = 0
  var actualWidth:Float = 0.0
  var actualHeight:Float = 0.0
  
  override func prepareLayout()
  {
    super.prepareLayout()
    
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
      optimalWidth = 190.0
      optimalHeight = 45.0
    }else{
      optimalWidth = 120.0
      optimalHeight = 35.0
    }
    
    columns = Int(Float(self.collectionView!.bounds.size.width) / optimalWidth)
    rows = Int(Float(self.collectionView!.bounds.size.height) / optimalHeight)
    
    //Width
    var q = self.collectionView!.bounds.size.width
      - CGFloat(columns)*CGFloat(minItemSpace) - CGFloat(minItemSpace)*2.0
    actualWidth = Float(q) / Float(columns)
    
    //Height
    q = self.collectionView!.bounds.size.height - CGFloat(rows)*CGFloat(minLineSpace) - CGFloat(minLineSpace)*2.0
    actualHeight = Float(q) / Float(rows)
    
    self.minimumInteritemSpacing = CGFloat(minItemSpace)
    self.minimumLineSpacing = CGFloat(minLineSpace)
    self.sectionInset = UIEdgeInsets(top: CGFloat(minLineSpace), left: CGFloat(minItemSpace), bottom: CGFloat(minLineSpace), right: CGFloat(minItemSpace))
    self.itemSize = CGSize(width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    
  }
  
}
