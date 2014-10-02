//
//  EmojiCollectionDataSource.swift
//  Emojiboard
//
//  Created by Andrew K. on 7/14/14.
//  Copyright (c) 2014 Andrew Kharchyshyn. All rights reserved.
//

import UIKit
import CoreData
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
  
  var activeCategory: EmojiCategory = .Angry
  
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
    var request = NSFetchRequest(entityName: "Kaomoji")
    var results = self.managedObjectContext?.executeFetchRequest(request, error: nil)
    
//    let myPersonClass: AnyClass = NSClassFromString("Emojicons.Kaomoji")
    
    kaomojis = results as? Array<Kaomoji>
    
  }
  
  
  
  
  
  
  
  // MARK: - Core Data stack
  
  lazy var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.rs..SampleCoreData" in the application's documents Application Support directory.
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1] as NSURL
    }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
    return NSManagedObjectModel(contentsOfURL: modelURL!)
    }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    var directory = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.Emojicons")
    var urlString = directory!.absoluteString!
    urlString = urlString + "Model.sqlite"
    let url = NSURL(string: urlString)
    var error: NSError? = nil
    var failureReason = "There was an error creating or loading the application's saved data."
    if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
      coordinator = nil
      // Report any error we got.
      let dict = NSMutableDictionary()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
      dict[NSLocalizedFailureReasonErrorKey] = failureReason
      dict[NSUnderlyingErrorKey] = error
      error = NSError.errorWithDomain("YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      // Replace this with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
      abort()
    }
    
    return coordinator
    }()
  
  lazy var managedObjectContext: NSManagedObjectContext? = {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    let coordinator = self.persistentStoreCoordinator
    if coordinator == nil {
      return nil
    }
    var managedObjectContext = NSManagedObjectContext()
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
    }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    if let moc = self.managedObjectContext {
      var error: NSError? = nil
      if moc.hasChanges && !moc.save(&error) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog("Unresolved error \(error), \(error!.userInfo)")
        abort()
      }
    }
  }
  
}
