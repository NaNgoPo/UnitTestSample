//
//  SwipeChoosenViewCell.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit

class SwipeChoosenViewCell: UICollectionViewCell {
  let highlightColor = UIColor.white
  let unHighlightColor = UIColor.init(red: 204.0 / 255.0, green: 77.0 / 255.0, blue: 83.0 / 255.0, alpha: 1.0)
  @IBOutlet weak var labelCenter: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func setInfo(displayText:String,withSelected:Bool){
    labelCenter.text = displayText
    if(withSelected){
      labelCenter.textColor = highlightColor
    }else{
       labelCenter.textColor = unHighlightColor
    }
  }
}
