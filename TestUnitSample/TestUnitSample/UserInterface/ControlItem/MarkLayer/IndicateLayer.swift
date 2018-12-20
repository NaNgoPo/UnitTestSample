//
//  IndicateLayer.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit

class IndicateLayer: UIView {
  private let padding = 20.0
  private let distance = 100.0
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
      let totalDistance = padding + distance // total distance include padding
      let witdthView = Double(self.frame.size.width)
      let heightView = Double(self.frame.size.height)
      ctx.setFillColor(UIColor.green.cgColor)
      //top left edge
      ctx.move(to: CGPoint(x: padding, y: totalDistance))
      ctx.addLine(to: CGPoint(x: padding, y: padding))
      ctx.addLine(to: CGPoint(x: totalDistance, y: padding))

      //topright edge
      ctx.move(to: CGPoint(x: witdthView - (padding), y: totalDistance))
      ctx.addLine(to: CGPoint(x: witdthView - (padding), y: padding))
      ctx.addLine(to: CGPoint(x: witdthView - (totalDistance), y: padding))
      //bottom left
      ctx.move(to: CGPoint(x: padding, y: heightView - totalDistance))
      ctx.addLine(to: CGPoint(x: padding, y: heightView - padding))
      ctx.addLine(to: CGPoint(x: totalDistance, y: heightView - padding))
      //bottom right
      ctx.move(to: CGPoint(x: witdthView - (padding), y: heightView - totalDistance))
      ctx.addLine(to: CGPoint(x:  witdthView - (padding), y: heightView - padding))
      ctx.addLine(to: CGPoint(x: witdthView - (totalDistance), y: heightView - padding))
      
      ctx.setStrokeColor(UIColor.white.cgColor)
      ctx.setLineWidth(10.0)
      ctx.strokePath()
      UIGraphicsEndImageContext()
    }
  }

}
