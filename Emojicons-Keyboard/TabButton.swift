//
//  TabButton.swift
//  Emojicons
//
//  Created by Andrew K. on 9/30/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class TabButton: UIView {
  
  @IBOutlet weak var backgroundView: UIView?
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    backgroundView?.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    backgroundView?.backgroundColor = UIColor.clearColor()
  }
  
}
