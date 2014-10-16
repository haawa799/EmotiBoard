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
    case 5,29:
      kaomoji.categoryIndex = 0
    case 7,28:
      kaomoji.categoryIndex = 1
    case 1:
      kaomoji.categoryIndex = 2
    case 11:
      kaomoji.categoryIndex = 3
    case 13,15,16,18,20:
      kaomoji.categoryIndex = 4
    case 8:
      kaomoji.categoryIndex = 5
    
    default:
      kaomoji.categoryIndex = 10
    }
    
    context.save(nil)
  }
  
  public func changeFavoriteState(#context: NSManagedObjectContext){
    self.favorite = !self.favorite;
    context.save(nil)
  }
  
}
