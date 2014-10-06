//
//  KeyboardViewController.swift
//  Emojicons-Keyboard
//
//  Created by Andrew K. on 9/25/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate , TabBarProtocol {
  
  var currentTab = KeyboardMode.Normal
  var isBackspacePressed = false
  
  let emojiDataSource = EmojiCollectionDataSource()

  @IBOutlet weak var titleView: TitleView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tabBar: TabBar!
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
    
    self.tabBar.delegate = self
    
    updateTitle()
  }
  
  //MARK: - UICollectionViewDelegate
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    //
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as EmojiCell
    if let proxy = self.textDocumentProxy as? UITextDocumentProxy
    {
      proxy.insertText(cell.label.text!)
      cell.kaomoji?.date = NSDate()
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
//    collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
    collectionView!.reloadData()
  }
  
  private func delay(delay:Double, closure:()->()) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
  }
  
  private func showHideTilteBar(){
    if titleView.hidden{
      titleViewHeightConstraint.constant = 0
    }else{
      titleViewHeightConstraint.constant = collectionView.bounds.height / CGFloat(8)
    }
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
  
  //MARK: - TabBarProtocol
  func backspacePressed(){
    isBackspacePressed = true
    backspaceDelete()
  }
  
  func backspaceReleased(){
    isBackspacePressed = false
  }
  
  func nextKeyboardPressed(){
    advanceToNextInputMode()
  }
  
  func tabPressed(#mode:KeyboardMode){
    
    if mode != currentTab{
      switch (mode){
      case .Normal:
        titleView.hidden = false
      default:
        titleView.hidden = true
      }
      currentTab = mode
      showHideTilteBar()
      self.emojiDataSource.tab = mode
      collectionView.reloadData()
    }
  }
  
  func backspaceDelete(){
    (textDocumentProxy as UIKeyInput).deleteBackward()
    delay(0.3, closure: {
      if self.isBackspacePressed{
        self.backspaceDelete()
      }
    })
  }
  
}
