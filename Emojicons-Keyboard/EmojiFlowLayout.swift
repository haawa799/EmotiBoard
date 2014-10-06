//
//  EmojiFlowLayout.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/15/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit

class EmojiFlowLayout: UICollectionViewFlowLayout {
  
  let optimalWidth:Float = 150.0
  
  let optimalHeight:Float = 40.0
  
  let minLineSpace:Float = 1.0
  let minItemSpace:Float = 1.0
  
  
  var columns = 0
  var rows = 0
  var actualWidth:Float = 0.0
  var actualHeight:Float = 0.0
  
  override func prepareLayout()
  {
    super.prepareLayout()
    
    columns = Int(Float(self.collectionView!.bounds.size.width) / optimalWidth)
    rows = Int(Float(self.collectionView!.bounds.size.height) / optimalHeight)
    actualWidth = Float(self.collectionView!.bounds.size.width
      - CGFloat(columns)*CGFloat(minItemSpace) - CGFloat(minItemSpace)*2.0) / Float(columns)
    actualHeight = Float(self.collectionView!.bounds.size.height - CGFloat(rows)*CGFloat(minLineSpace) - CGFloat(minLineSpace)*2.0) / Float(rows)
    
    self.minimumInteritemSpacing = CGFloat(minItemSpace)
    self.minimumLineSpacing = CGFloat(minLineSpace)
    self.sectionInset = UIEdgeInsets(top: CGFloat(minLineSpace), left: CGFloat(minItemSpace), bottom: CGFloat(minLineSpace), right: CGFloat(minItemSpace))
    self.itemSize = CGSize(width: CGFloat(actualWidth), height: CGFloat(actualHeight))
    
  }
  
}
