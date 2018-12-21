//
//  ButtonCameraAction.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Stellar
import ReactiveCocoa
import ReactiveSwift
import Result

enum ButtonSignal{
  case Pressed
  case CompleteRun
}
class ButtonCameraAction: UIViewController {
  let (buttonObserve, buttonInputSignal) = Signal<ButtonSignal, NoError>.pipe()
  private let circleProgress = ProgressLayer()
  private let maximumTimeRecord = 10.0
  //  var processAction:(() -> Void)?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(circleProgress)
    circleProgress.isUserInteractionEnabled = false
  }
  override func viewDidLayoutSubviews() {
    self.view.layer.cornerRadius = self.view.frame.size.width / 2.0
    self.view.clipsToBounds = true
    circleProgress.frame = self.view.frame
  }
  func setCameraMode(mode:ChoosenMode){
    circleProgress.isHidden = (mode == .Camera)
  }
  @IBAction func buttonProcessDidPressed(_ sender: Any) {
    buttonInputSignal.send(value: .Pressed)
  }
  func startCountingRecord(){
    self.circleProgress.animatedrawing(newPercentage: 0.0)
    let zeroPercent = 0.0
    let maximumPercent = 100.0
    zeroPercent.animate(to: maximumPercent, duration: maximumTimeRecord, delay: 0.0, type: TimingFunctionType.linear, autoreverses: false, repeatCount: 1, render: { (value) in
      self.circleProgress.animatedrawing(newPercentage: value)
    }) { [weak self] (completed) in
      guard let self = self else{
        return
      }
      print("complete animated!!!!")
      self.circleProgress.animatedrawing(newPercentage: zeroPercent)
      self.buttonInputSignal.send(value: .CompleteRun)
    }
  }
}
