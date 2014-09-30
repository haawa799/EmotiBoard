//
//  KeyboardViewController.swift
//  Emojicons-Keyboard
//
//  Created by Andrew K. on 9/25/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

enum KeyboardMode{
  case Normal
  case History
  case Favorites
}

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate {
  
  var currentTab = KeyboardMode.Normal
  
  let emojiDataSource = EmojiCollectionDataSource()
  
  @IBOutlet var nextKeyboardButton: UIButton!
  
  @IBOutlet weak var titleView: TitleView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var emojiconsModeButton: UIButton!
  @IBOutlet weak var favoritesModeButton: UIButton!
  @IBOutlet weak var historyModeButton: UIButton!
  
  @IBOutlet weak var titleViewHeightConstraint: NSLayoutConstraint!
  
  //MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    let nib = UINib(nibName: "KeyboardView", bundle: nil)
    let objects = nib.instantiateWithOwner(self, options: nil)
    let containerView = objects[0] as UIView
    view = containerView
    
    self.collectionView.registerClass(EmojiCell.self,forCellWithReuseIdentifier: "Emoji")
    self.collectionView.dataSource = emojiDataSource
    self.collectionView.delegate = self
    
    updateTitle()
  }
  
  //MARK: - UICollectionViewDelegate
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    //
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as EmojiCell
    if let proxy = self.textDocumentProxy as? UITextDocumentProxy
    {
      proxy.insertText(cell.label.text!)
    }
  }
  
  //MARK: - Actions
  
  @IBAction func nextKeyboard(sender: AnyObject) {
    advanceToNextInputMode()
  }
  
  @IBAction func backspaceAction(sender: AnyObject) {
    (textDocumentProxy as UIKeyInput).deleteBackward()
    titleView.hidden = !titleView.hidden
    
    if titleView.hidden{
      titleViewHeightConstraint.constant = 0
    }else{
      titleViewHeightConstraint.constant = collectionView.bounds.height / CGFloat(8)
    }
  }
  
  //MARK: - Private
  
  private func hideUnhideTopBar(){
  }
  
  private func setupGestures(){
//    var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector.convertFromStringLiteral("leftSwipe:"))
//    leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
//    view.addGestureRecognizer(leftSwipe)
//    
//    var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector.convertFromStringLiteral("rightSwipe:"))
//    rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
//    view.addGestureRecognizer(rightSwipe)
  }
  
  private func updateTitle(){
    var title = emojiDataSource.category.description()
    titleView.label!.text = title
  }
  
  private func reloadEmojes(){
    collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
    collectionView!.reloadData()
  }
  
  //MARK: - Gestures
  
  @IBAction func rightSwipe(sender: UISwipeGestureRecognizer) {
    var title = emojiDataSource.previousCategory()
    titleView.previousPage()
    updateTitle()
    reloadEmojes()
  }
  
  @IBAction func leftSwipe(sender: UISwipeGestureRecognizer) {
    var title = emojiDataSource.nextCategory()
    titleView.nextPage()
    updateTitle()
    reloadEmojes()
  }
  
}
