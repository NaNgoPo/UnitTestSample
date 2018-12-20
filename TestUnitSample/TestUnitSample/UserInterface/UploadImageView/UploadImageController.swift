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
        self.presentAll(fetchedInfo:images)
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
  func presentAll(fetchedInfo:PHFetchResult<PHAsset>){
    
  }
}
