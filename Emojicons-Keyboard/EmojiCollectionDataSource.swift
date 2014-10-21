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
  case Sad = 4
  case Bored = 5
  case Animals = 6
  case Mustaches = 7
  case FoodDrink  = 8
  case Others = 9
  
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
    case .Sad :
      return "Sad"
    case .Bored :
      return "Bored"
    case .Animals :
      return "Animals"
    case .Mustaches :
      return "Mustaches"
    case .FoodDrink :
      return "Food/Drinks"
    case .Others :
      return "Others"
    }
  }
  
}

protocol EmojiCollectionDataSourceDelegate{
  func favoritesRefreshed(#empty: Bool)
}

class EmojiCollectionDataSource: NSObject,UICollectionViewDataSource {
  
  var kaomojis:[Kaomoji]?
  var delegate: EmojiCollectionDataSourceDelegate?
  
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
    var cell: EmojiCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as EmojiCollectionViewCell
    
    if let kaomojis = kaomojis{
      cell.kaomoji = kaomojis[indexPath.item]
    }
    
    return cell as UICollectionViewCell
  }
  
  func nextCategory() -> String{
    if category.rawValue < EmojiCategory.Others.rawValue{
      category = EmojiCategory(rawValue: category.rawValue+1)!
    }
    return category.description()
  }
  
  func previousCategory() -> String{
    if category.rawValue > EmojiCategory.HappyLol.rawValue{
      category = EmojiCategory(rawValue: category.rawValue-1)!
    }
    return category.description()
  }
  
  
  private func reloadKaomojisFromCoreData(){
    
    if tab == KeyboardMode.Normal{
      kaomojis = KaomojiCoreDataManager.sharedInstance.emojiconsForCategoryIndex(categoryIndex: Int16(category.rawValue))!
    }else if tab == KeyboardMode.Favorites{
      kaomojis = KaomojiCoreDataManager.sharedInstance.favoriteEmojicons()!
      self.delegate?.favoritesRefreshed(empty: kaomojis?.count == 0)
    }else if tab == KeyboardMode.History{
      kaomojis = KaomojiCoreDataManager.sharedInstance.recentEmojicons()!
    }
    
  }
  
  
  
  
  
  
  
  
  
}
