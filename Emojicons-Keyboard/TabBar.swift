//
//  TabBar.swift
//  Emojicons
//
//  Created by Andrew K. on 9/30/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

enum KeyboardMode{
  case Normal
  case History
  case Favorites
}

protocol TabBarProtocol{
  
  func backspacePressed()
  func backspaceReleased()
  
  func nextKeyboardPressed()
  
  func tabPressed(#mode:KeyboardMode)
}

class TabBar: UIView, TabButtonDelegate {
  
  @IBOutlet weak var nextKeyboardTabButton: TabButton?
  @IBOutlet weak var normalModeTabButton: TabButton?
  @IBOutlet weak var favoritesModeTabButton: TabButton?
  @IBOutlet weak var historyModeTabButton: TabButton?
  @IBOutlet weak var backspaceTabButton: TabButton?
  
  var delegate: TabBarProtocol?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    nextKeyboardTabButton?.delegate = self
    normalModeTabButton?.delegate = self
    favoritesModeTabButton?.delegate = self
    historyModeTabButton?.delegate = self
    backspaceTabButton?.delegate = self
  }
  
  //MARK: - TabButtonDelegate
  
  func tabButtonTouchBegin(#tabButton: TabButton){
    if tabButton == nextKeyboardTabButton{
      delegate?.nextKeyboardPressed()
    }else if tabButton == normalModeTabButton{
      delegate?.tabPressed(mode: .Normal)
      normalModeTabButton?.isSelected = true
      favoritesModeTabButton?.isSelected = false
      historyModeTabButton?.isSelected = false
    }else if tabButton == favoritesModeTabButton{
      delegate?.tabPressed(mode: .Favorites)
      normalModeTabButton?.isSelected = false
      favoritesModeTabButton?.isSelected = true
      historyModeTabButton?.isSelected = false
    }else if tabButton == historyModeTabButton{
      delegate?.tabPressed(mode: .History)
      normalModeTabButton?.isSelected = false
      favoritesModeTabButton?.isSelected = false
      historyModeTabButton?.isSelected = true
    }else if tabButton == backspaceTabButton{
      delegate?.backspacePressed()
    }
  }
  
  func tabButtonTouchEnded(#tabButton: TabButton){
    if tabButton == backspaceTabButton{
      delegate?.backspaceReleased()
    }
  }
  
}



