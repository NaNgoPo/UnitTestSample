//
//  PHAssetMock.swift
//  TestUnitSampleTests
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Photos
@testable import TestUnitSample
// partial test for mocking
class PHAssetMock: PhotosRepository {
  private var returnInfo:PHAuthorizationStatus = .authorized
  convenience init(withReturn expectedreturn:PHAuthorizationStatus) {
    self.init()
    returnInfo = expectedreturn
  }
  override func getAccessPhotosPermission(_ handler: @escaping (PHAuthorizationStatus) -> Void){
      handler(self.returnInfo)
  }
}
