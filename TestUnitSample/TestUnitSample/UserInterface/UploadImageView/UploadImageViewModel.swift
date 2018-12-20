//
//  UploadImageViewModel.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Photos
import Result
import ReactiveSwift

enum FetchError: Error {
  case noPermission(String)
  case unknow(String)
}

class UploadImageViewModel: NSObject {
  private var photosRepo = PhotosRepository()
  var(getAllImageSignal,observerFetch) = Signal<PHFetchResult<PHAsset>, FetchError>.pipe()
  var inputSignal:Signal<PHFetchResult<PHAsset>, FetchError>.Observer?
  
  override init() {
    inputSignal = observerFetch
  }
  convenience init(withPhotoRepo:PhotosRepository) {//
    self.init()
    photosRepo = withPhotoRepo
  }
  func getAllImagesForDisplay(){
    photosRepo.getAccessPhotosPermission { [weak self] status in
      guard let self = self,
        let inputSignal = self.inputSignal else{
          return
      }
      switch status {
      case .authorized:
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        print("Found \(allPhotos.count) images")
        inputSignal.send(value: allPhotos)
      case .denied, .restricted:
        inputSignal.send(error: FetchError.noPermission("no permission"))
        print("")
      case .notDetermined:
        inputSignal.send(error: FetchError.unknow("unknow error founded"))
        print("")
      }
    }
  }
}
