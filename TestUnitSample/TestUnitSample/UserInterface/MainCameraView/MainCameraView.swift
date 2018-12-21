//
//  MainCameraView.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift
import CameraManager

class MainCameraView: UIViewController {
  /**
   cameraDisplay: an UIView holder for displaying camera
   mainCameraController: private controller for the view
   */
  @IBOutlet weak var cameraDisplay: UIView!
  var mainCameraController = MainCameraController()
  let swipeableChoosen = SwipeChoosen()
  private let focusLayerDrawing = FoscusMarkLayer(frame: CGRect.zero)
  private let indicateLayerDrawing = IndicateLayer(frame: CGRect.zero)
  private let buttonCenter = ButtonCameraAction()
  
  @IBOutlet weak var labelTimeCounting: UILabel!
  @IBOutlet weak var holderSwipeableView: UIView!
  @IBOutlet weak var buttonFlash: UIButton!
  @IBOutlet weak var focusLayer: UIView!
  @IBOutlet weak var viewButton: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let flashSignalObs = Signal<CameraFlashMode, NoError>.Observer { (event) in
      switch event {
      case let .value(flashMode):
        self.changeFlashLayout(flashStyle:flashMode)
      default:
        break
      }
    }
    mainCameraController.flashModeSignal.observe(flashSignalObs)
    
    let swipeSignal =  Signal<ChoosenMode, NoError>.Observer { (event) in
      switch event {
      case let .value(swipeInfo):
        self.changeModeCaptureLayout(mode:swipeInfo)
      default:
        break
      }
    }
    swipeableChoosen.swipeSignal.observe(swipeSignal)
    
    self.holderSwipeableView.addSubview(self.swipeableChoosen.view)
    focusLayerDrawing.backgroundColor = UIColor.clear
    self.focusLayer.addSubview(focusLayerDrawing)
    self.focusLayer.addSubview(indicateLayerDrawing)
    self.viewButton.addSubview(buttonCenter.view)
    
    self.viewButton.backgroundColor = UIColor.clear
    self.setupRecordingTimeSignal()
    self.setUpButtonAction()
  }
  private func setUpButtonAction(){
    let observerButtonAction = Signal<ButtonSignal, NoError>.Observer{ [weak self] event in
      guard let self = self else{
        return
      }
      switch event {
      case let .value(signal):
        self.requestProcessAction()
      default:
        break
      }
    }
    self.buttonCenter.buttonObserve.observe(observerButtonAction)
  }
  private func setupRecordingTimeSignal(){
    let observerRecord = Signal<Double, NoError>.Observer{ [weak self] event in
      guard let self = self else{
        return
      }
      switch event {
      case let .value(recordSeconds):
        DispatchQueue.main.async {
          if(recordSeconds > 0){
            let secRecord = String(format: "%02d", Int(recordSeconds))
            self.labelTimeCounting.text = "00:00:\(secRecord)"
          }else{
            self.labelTimeCounting.text = "00:00:00"
          }
        }
      default:
        break
      }
    }
    self.mainCameraController.recordingTimerSignal.observe(observerRecord)
  }
  override func viewDidLayoutSubviews() {
    buttonCenter.view.frame = CGRect(origin: .zero, size: self.viewButton.frame.size)
    self.swipeableChoosen.view.frame = CGRect(origin: .zero, size: self.holderSwipeableView.frame.size)
    self.swipeableChoosen.snapToCorrectPossition()
    focusLayerDrawing.frame = CGRect(origin: .zero, size: self.focusLayer.frame.size)
    indicateLayerDrawing.frame = CGRect(origin: .zero, size: self.focusLayer.frame.size)
  }
  //MARK: UI-Test
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    mainCameraController.setUpCamera(forView: cameraDisplay)
  }
  @IBAction func buttonFlashDidPressed(_ sender: Any) {
    mainCameraController.switchFlashMode()
  }
  @IBAction func buttonSwitchCameraDidPressed(_ sender: Any) {
    mainCameraController.switchCameraFrontBack()
  }
  
  func requestProcessAction() {
    mainCameraController.actionDeviceCamera()
  }
  @IBAction func buttonGalleryDidPressed(_ sender: Any) {
    self.performSegue(withIdentifier: "showPopup", sender: self)
  }
  //MARK: private process funtion
  /**
   Change the capture mode of application
   - parameters:
   - mode: the defination of app
   */
  private func changeModeCaptureLayout(mode:ChoosenMode){
    mainCameraController.switchModeCapture(mode: mode.rawValue)
    labelTimeCounting.isHidden = (mode == .Camera)
    self.buttonCenter.setCameraMode(mode: mode)
  }
  /**
   Change the flash behaviorof application
   - parameters:
   - flashStyle: the flash mode style
   */
  private func changeFlashLayout(flashStyle:CameraFlashMode){
    var cameraIcon = "ic_flash_off"
    switch flashStyle {
    case .auto:
      cameraIcon = "ic_flash_auto"
    case .on:
      cameraIcon = "ic_flash_on"
    case .off:
      cameraIcon = "ic_flash_off"
    }
    DispatchQueue.main.async {
      self.buttonFlash.setImage(UIImage.init(named: cameraIcon), for: .normal)
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPopup"{
      //      var vc = segue.destination as! UploadImageView
    }
  }
  
}
