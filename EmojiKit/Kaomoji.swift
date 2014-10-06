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
  @NSManaged public var favorite: Bool
  
  public class func create(#context: NSManagedObjectContext, text: String, category: Int16){
    
    var kaomoji = Kaomoji(entity: NSEntityDescription.entityForName("Kaomoji", inManagedObjectContext: context)!, insertIntoManagedObjectContext: context)
    
    kaomoji.text = text
    kaomoji.favorite = false
    kaomoji.categoryIndex = category
    
    context.save(nil)
  }
  
  public func changeFavoriteState(#context: NSManagedObjectContext){
    self.favorite = !self.favorite;
    context.save(nil)
  }
  
}
