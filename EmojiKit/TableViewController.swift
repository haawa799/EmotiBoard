//
//  TableViewController.swift
//  Emojicons
//
//  Created by Andrew K. on 10/6/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
  
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var frame = CGRect(x: 0, y: 0, width: 0.9 * view.bounds.width, height: 10 * 44.0)
    
    tableView = UITableView(frame: frame,style: UITableViewStyle.Plain)
    
    tableView.center = view.center
    
    tableView.dataSource = self
    tableView.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tutCell")
    tableView.rowHeight = 44.0
    tableView.backgroundColor = UIColor.clearColor()
    tableView.separatorColor = UIColor.clearColor()
    tableView.scrollEnabled = false
    view.addSubview(tableView)
  }
  
  // MARK: - Table view data source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return 10
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("tutCell", forIndexPath: indexPath) as? TableViewCell
    
    if let cell = cell{
      cell.numberLabel.text = "\(indexPath.row+1)"
      
      
      var atribString: NSMutableAttributedString
      
      if indexPath.row == 0{
        atribString = NSMutableAttributedString(string: "Go to Settings")
        cell.rightImage.image = UIImage(named: "settings")
      }else if indexPath.row == 1{
        atribString = NSMutableAttributedString(string: "Tap on General")
        cell.rightImage.image = UIImage(named: "general")
      }else if indexPath.row == 2{
        atribString = NSMutableAttributedString(string: "Tap on Keyboard")
      }else if indexPath.row == 3{
        atribString = NSMutableAttributedString(string: "Tap on Keyboards")
      }else if indexPath.row == 4{
        atribString = NSMutableAttributedString(string: "Add New Keyboard")
      }else if indexPath.row == 5{
        atribString = NSMutableAttributedString(string: "Select Emojicons")
      }else if indexPath.row == 6{
        atribString = NSMutableAttributedString(string: "Tap Emojicons-Emojicons")
      }else if indexPath.row == 7{
        atribString = NSMutableAttributedString(string: "Allow full access")
        cell.rightImage.image = UIImage(named: "switch")
      }else if indexPath.row == 8{
        atribString = NSMutableAttributedString(string: "Allow")
      }else {
        atribString = NSMutableAttributedString(string: "Done")
      }
      
      cell.cellTitleLabel.attributedText = atribString
    }
    
    return cell!
  }
  
}


