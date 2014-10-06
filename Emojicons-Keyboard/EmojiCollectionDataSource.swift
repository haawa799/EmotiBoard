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
  case HappyLol = 0
  case LoveCute = 1
  case Angry = 2
  case Surprised = 3
  case Animals = 4
  case Sad = 5
  case NoYes = 6
  case Other = 7
  
  func description() -> String{
    switch (self){
    case .HappyLol :
      return "Happy/Lol"
    case .LoveCute :
      return "Love/Cute"
    case .Angry :
      return "Angry"
    case .Surprised :
      return "Surprised"
    case .Animals :
      return "Animals"
    case .Sad :
      return "Sad"
    case .NoYes :
      return "Yes/No"
    case .Other :
      return "Other"
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
  
  var category:EmojiCategory = .HappyLol{
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
      cell.kaomoji = kaomoji
    }
    
    return cell as UICollectionViewCell
  }
  
  func nextCategory() -> String{
    if category.toRaw() < EmojiCategory.Other.toRaw(){
      category = EmojiCategory.fromRaw(category.toRaw()+1)!
    }
    return category.description()
  }
  
  func previousCategory() -> String{
    if category.toRaw() > EmojiCategory.HappyLol.toRaw(){
      category = EmojiCategory.fromRaw(category.toRaw()-1)!
    }
    return category.description()
  }
  
  
  private func reloadKaomojisFromCoreData(){
    
    if tab == KeyboardMode.Normal{
      kaomojis = KaomojiCoreDataManager.sharedInstance.emojiconsForCategoryIndex(categoryIndex: Int16(category.toRaw()))!
    }else if tab == KeyboardMode.Favorites{
      kaomojis = KaomojiCoreDataManager.sharedInstance.favoriteEmojicons()!
    }else if tab == KeyboardMode.History{
      kaomojis = KaomojiCoreDataManager.sharedInstance.recentEmojicons()!
    }
    
  }
  
  
  
  
  
  
  
  
  
}
