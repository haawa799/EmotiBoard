//
//  Kaomoji.swift
//  Emojicons
//
//  Created by Andrew K. on 10/1/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit
import CoreData

public class Kaomoji: NSManagedObject {
  
  @NSManaged public var text: String?
  @NSManaged public var date: NSDate?
  @NSManaged public var categoryIndex: Int16
  @NSManaged public var oldCategory: Int16
  @NSManaged public var favorite: Bool
  
  public class func create(#context: NSManagedObjectContext, text: String, oldCategory: Int16){
    
    var kaomoji = Kaomoji(entity: NSEntityDescription.entityForName("Kaomoji", inManagedObjectContext: context)!, insertIntoManagedObjectContext: context)
    
    kaomoji.text = text
    kaomoji.favorite = false
    kaomoji.oldCategory = oldCategory
    
    switch (oldCategory){
    case 4,10,24://5,29:
      kaomoji.categoryIndex = 0
    case 7,13,15,27,28://7,28:
      kaomoji.categoryIndex = 1
    case 1,3,25,41:
      kaomoji.categoryIndex = 2
    case 2,9,26:
      kaomoji.categoryIndex = 3
    case 6,8,12,22,23:
      kaomoji.categoryIndex = 4
    case 32,40,45:
      kaomoji.categoryIndex = 5
    case 13,15,16,18,20:
      kaomoji.categoryIndex = 6
    case 46:
      kaomoji.categoryIndex = 7
    case 42:
      kaomoji.categoryIndex = 8
    case 39,44,47,49:
      kaomoji.categoryIndex = 9
    default:
      kaomoji.categoryIndex = -1
    }
    
    context.save(nil)
  }
  
  public func changeFavoriteState(#context: NSManagedObjectContext){
    self.favorite = !self.favorite;
    context.save(nil)
  }
  
}
