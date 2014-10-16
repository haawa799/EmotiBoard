//
//  ViewController.swift
//  Emojicons
//
//  Created by Andrew K. on 9/25/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.performSegueWithIdentifier("segueQ", sender: self)
  }
  
}

