//
//  MainCameraController.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import CameraManager
import Result
import ReactiveCocoa
import ReactiveSwift

class MainCameraController: NSObject {
  //MARK: Private state
  private let cameraManager = CameraManager()
  //MARK: Signal props
  let (flashModeSignal, inputFlashSignal) = Signal<CameraFlashMode, NoError>.pipe()
  
  //MARK: PUBLIC FUNC
  /**
   Initial setup all the camera.
   Send a request sync signal to the view after the setup completed
   */
  func setUpCamera(forView cameraHolder:UIView){
    cameraManager.addPreviewLayerToView(cameraHolder)
    cameraManager.flashMode = .off
    self.sendSyncSignal()
  }
  /**
   Switching the flash mode.
   Auto switching infinitive with sequence off-on-auto-off(again)....
   */
  func switchFlashMode(){
    let loopFlashMode = [CameraFlashMode.off,CameraFlashMode.on,CameraFlashMode.auto]
    let index = loopFlashMode.lastIndex { (mode) -> Bool in
      return cameraManager.flashMode == mode
    }
    if(index == (loopFlashMode.count - 1)){
      cameraManager.flashMode = .off
    }else{
      cameraManager.flashMode = loopFlashMode[index! + 1]
    }
    self.sendSyncSignal()
  }
  func switchCameraFrontBack(){
    if(cameraManager.cameraDevice == .front){
      cameraManager.cameraDevice = .back
    }else{
      cameraManager.cameraDevice = .front
    }
  }
  func switchModeCapture(mode:Int){
    if(mode == 0){
      DispatchQueue.global(qos: .background).async {
        self.cameraManager.cameraOutputMode = .stillImage
      }
    }else{
      DispatchQueue.global(qos: .background).async {
        self.cameraManager.cameraOutputMode = .videoWithMic
      }
    }
  }
  func actionDeviceCamera() {
    if(self.cameraManager.cameraOutputMode == .stillImage){// image mode = capture a picture
      self.capturePic()
    }
  }
}

//MARK: PRIVATE FUNC
extension MainCameraController{
  /**
   Send all the sync signal to the view that hold value
   */
  private func sendSyncSignal(){
    inputFlashSignal.send(value: cameraManager.flashMode)
  }
  private func capturePic(){
    self.cameraManager.capturePictureWithCompletion { (image, error) in
      //TODO: catch the callback
    }
  }
}
