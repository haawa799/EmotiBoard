//
//  EmojiCollectionDataSource.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/14/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit
import EmojiKit

enum EmojiCategory: Int{
  case Angry = 0
  case Happy = 1
  case Sad = 2
  case WTF = 3
  case Smile = 4
  
  func description() -> String{
    switch (self){
    case .Angry :
      return "Angry"
    case .Happy :
      return "Happy"
    case .Sad :
      return "Sad"
    case .WTF :
      return "WTF"
    case .Smile :
      return "Smile"
    }
  }
  
}

class EmojiCollectionDataSource: NSObject,UICollectionViewDataSource {
  
  var kaomojis:[Kaomoji]?
  
  var tab: KeyboardMode = .Normal{
    didSet{
      reloadKaomojisFromCoreData()
    }
  }
  
  let reuseIdentifier = "Emoji"
  
  var category:EmojiCategory = .Angry{
    didSet{
      reloadKaomojisFromCoreData()
    }
  }
  
  //    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
  //    {
  //
  //    }
  //
  //    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  //    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
  //    {
  //
  //    }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    if let kaomojis = kaomojis{
      return kaomojis.count
    }
    return 0
  }
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    var cell: EmojiCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as EmojiCell
    
    var text = ""
    
    if let kaomojis = kaomojis{
      var kaomoji = kaomojis[indexPath.item] as Kaomoji
      text = kaomoji.text!
    }
    
    cell.label.text = text
    
    return cell as UICollectionViewCell
  }
  
  func nextCategory() -> String{
    if category.toRaw() < EmojiCategory.Smile.toRaw(){
      category = EmojiCategory.fromRaw(category.toRaw()+1)!
    }
    return category.description()
  }
  
  func previousCategory() -> String{
    if category.toRaw() > EmojiCategory.Angry.toRaw(){
      category = EmojiCategory.fromRaw(category.toRaw()-1)!
    }
    return category.description()
  }
  
  
  private func reloadKaomojisFromCoreData(){
    
    if tab == KeyboardMode.Normal{
      kaomojis = KaomojiCoreDataManager.sharedInstance.emojiconsForCategoryIndex(categoryIndex: Int16(category.toRaw()))!
    }else if tab == KeyboardMode.Favorites{
      kaomojis = KaomojiCoreDataManager.sharedInstance.favoriteEmojicons()!
    }
    
  }
  
  
  
  
  
  
  
  
  
}
