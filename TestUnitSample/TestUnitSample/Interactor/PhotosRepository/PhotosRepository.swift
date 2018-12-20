//
//  PhotosRepository.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Photos
class PhotosRepository: NSObject {
  func getAccessPhotosPermission(_ handler: @escaping (PHAuthorizationStatus) -> Void){
    PHPhotoLibrary.requestAuthorization {[weak self] status in
      handler(status)
    }
  }
  func fetchAllThumb(){
  }
}
