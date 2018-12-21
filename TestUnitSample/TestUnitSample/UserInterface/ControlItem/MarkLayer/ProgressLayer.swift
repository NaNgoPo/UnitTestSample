//
//  ProgressLayer.swift
//  TestUnitSample
//
//  Created by East Agile on 12/21/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit

class ProgressLayer: UIView {

  private var currentPercent = 0.0

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    self.isOpaque = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    if let ctx = UIGraphicsGetCurrentContext() {
      let witdthView = Double(self.frame.size.width)
      let heightView = Double(self.frame.size.height)
      let convertedAngle = currentPercent * 360.0 / 100.0 // 100% = 360degree, so need to convert the percent to correct value of angle
      let haftViewSize = witdthView / 2.0
      let centerPoint = CGPoint(x: haftViewSize, y: haftViewSize)
      ctx.setFillColor(UIColor.green.cgColor)
      ctx.setStrokeColor(UIColor.green.cgColor)
      ctx.addArc(center: centerPoint, radius: CGFloat(haftViewSize), startAngle: 0.0, endAngle: CGFloat.pi * CGFloat(convertedAngle / 180.0), clockwise: true)
      
      ctx.setLineWidth(10.0)
      ctx.strokePath()
      UIGraphicsEndImageContext()
    }
  }
  
  func animatedrawing(newPercentage:Double){
      self.currentPercent = newPercentage
     self.setNeedsDisplay()
  }
}
