//
//  UploadImageController.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import Photos

class UploadImageController: NSObject {
  var imageFetchSignalObs:Signal<PHFetchResult<PHAsset>, FetchError>.Observer?
  
  var (imageFetchSignal,imageFetchInput) = Signal<PHFetchResult<PHAsset>, FetchError>.pipe()
  
  let viewModel = UploadImageViewModel()
  override init() {
    super.init()
    imageFetchSignalObs = Signal<PHFetchResult<PHAsset>, FetchError>.Observer{ [weak self] event in
      guard let self = self else{
        return
      }
      switch event {
      case let .value(images):
        print("getAllimages")
        self.imageFetchInput.send(value: images)
      case let .failed(Error):
        print("error")
      default:
        break
      }
    }
    viewModel.getAllImageSignal.observe(imageFetchSignalObs!)
  }
  
  func fetchAllImages(){
    viewModel.getAllImagesForDisplay()
  }
  
  func requestProcessTap(index valueNeedCheck:Int) {
    let tryToFindIndex = viewModel.listOfChooseImages.firstIndex(of: valueNeedCheck)
    if let founded = tryToFindIndex{
      self.unChooseAnImageAt(index: founded)
    }else{
      self.chooseAnImageAt(index: valueNeedCheck)
    }
  }
  private func chooseAnImageAt(index:Int){
    let emptySlotIndex = viewModel.listOfChooseImages.firstIndex(of: -1)
    if let foundedEmptySlot = emptySlotIndex{
      viewModel.listOfChooseImages[foundedEmptySlot] = index
    }else{
      print("max slot found \(viewModel.listOfChooseImages)")
    }
  }
  private func unChooseAnImageAt(index:Int){
      viewModel.listOfChooseImages[index] = -1
    print("unselect \(index)")
  }
}
