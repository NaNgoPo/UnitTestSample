//
//  FoscusMarkLayer.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit

class FoscusMarkLayer: UIView {
  let padding = 10.0
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
      ctx.setFillColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor)
      ctx.addRect(rect)
      ctx.fillPath()
      let smallRect = CGRect(x: padding, y: padding, width: Double(rect.size.width) - (padding * 2.0), height: Double(rect.size.height) - (padding * 2.0))
      createAHole(rectParent: rect, smallRect: smallRect)
      createLineFocus(withPading: CGFloat(padding + padding), andDistance: CGFloat(100.0),context:ctx)   
      UIGraphicsEndImageContext()
    }
  }
  func createAHole(rectParent:CGRect,smallRect:CGRect){
    let layer = CAShapeLayer()
    let path = CGMutablePath()
    path.addRect(smallRect)
    path.addRect(rectParent)
    layer.path = path
    layer.fillRule = .evenOdd
    self.layer.mask = layer
  }
  func createLineFocus(withPading padding:CGFloat,andDistance distance:CGFloat,context:CGContext){
    let farDistance = padding + distance
   
   
  }
}
