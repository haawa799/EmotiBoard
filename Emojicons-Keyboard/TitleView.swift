//
//  TitleView.swift
//  Emojicons
//
//  Created by Andrew K. on 9/29/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class TitleView: UIView {
  
  @IBOutlet var label:UILabel?
  @IBOutlet var pageControl:UIPageControl?
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect)
  {
  // Drawing code
  }
  */
  
  func nextPage(){
    if pageControl!.currentPage != pageControl!.numberOfPages{
      pageControl!.currentPage = pageControl!.currentPage + 1
    }
  }
  
  func previousPage(){
    if pageControl!.currentPage != 0{
      pageControl!.currentPage = pageControl!.currentPage - 1
    }
  }
  
}
