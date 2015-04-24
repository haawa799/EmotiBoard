//
//  TabButton.swift
//  Emojicons
//
//  Created by Andrew K. on 9/30/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

protocol TabButtonDelegate{
  func tabButtonTouchBegin(#tabButton: TabButton)
  func tabButtonTouchEnded(#tabButton: TabButton)
}

@IBDesignable class TabButton: UIView {
  
  @IBInspectable var notSelectable:Bool = false
  
  var delegate: TabButtonDelegate?
  
  let selectedColor = UIColor.clearColor()
  let notSelectedColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
  
  let specialNotSelected = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
  let specialSelected = UIColor.clearColor()
  
  @IBInspectable var isSelected:Bool = false{
    didSet{
      if notSelectable{
        if isSelected{
          backgroundView?.backgroundColor = specialSelected
        }else{
          backgroundView?.backgroundColor = specialNotSelected
        }
      }else{
        if isSelected{
          backgroundView?.backgroundColor = selectedColor
        }else{
          backgroundView?.backgroundColor = notSelectedColor
        }
      }
    }
  }
  
  @IBOutlet weak var backgroundView: UIView?
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if notSelectable == true{
      isSelected = true
    }else{
      isSelected = !isSelected
    }
    delegate?.tabButtonTouchBegin(tabButton: self)
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    if notSelectable == true{
      isSelected = false
    }
    delegate?.tabButtonTouchEnded(tabButton: self)
  }
  
}
