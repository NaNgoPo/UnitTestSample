//
//  CamVideoRecordTests.swift
//  CamVideoRecordTests
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import XCTest
import Photos
@testable import TestUnitSample

class UploadImageControllerTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  func testFetchAllImagesErrorNoPermission(){
    //Arrange
    let sut = UploadImageController()
    let expect = expectation(description: "no permission")
    //Action
    sut.viewModel.getAllImageSignal.observeFailed { (error) in
      expect.fulfill()
    }
    sut.viewModel.observerFetch.send(error: FetchError.noPermission("no permission"))
    //Assert after waiting
    wait(for: [expect], timeout: 1.0)
  }
  func testFetchAllImagesUnknowError(){
    //Arrange
    let sut = UploadImageController()
    let expect = expectation(description: "Unknow error")
    //Action
    sut.viewModel.getAllImageSignal.observeFailed { (error) in
      expect.fulfill()
    }
    sut.viewModel.observerFetch.send(error: FetchError.unknow("Unknow error"))
    //Assert after waiting
    wait(for: [expect], timeout: 1.0)
  }
  func testFetchAllImagesSuccess(){
    //Arrange
    let sut = UploadImageController()
    let expect = expectation(description: "success")
    //Action
    sut.viewModel.getAllImageSignal.observeResult { (value) in
      expect.fulfill()
    }
    sut.viewModel.observerFetch.send(value: PHFetchResult<PHAsset>())
    //Assert after waiting
    wait(for: [expect], timeout: 1.0)
  }
  func testFetchAllImagesInterupted(){
    //Arrange
    let sut = UploadImageController()
    let expect = expectation(description: "success")
    //Action
    sut.viewModel.getAllImageSignal.observe { (event) in
      expect.fulfill()
    }
    sut.viewModel.observerFetch.sendInterrupted()
    //Assert after waiting
    wait(for: [expect], timeout: 1.0)
  }
  func testFailedPermission(){
    let assetMock = PHAssetMock.init(withReturn: .denied)
    let sut = UploadImageViewModel.init(withPhotoRepo: assetMock)
    
    
  }
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
