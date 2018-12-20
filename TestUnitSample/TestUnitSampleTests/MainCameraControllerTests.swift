//
//  MainCameraControllerTests.swift
//  CamVideoRecordTests
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import XCTest
@testable import TestUnitSample
class MainCameraControllerTests: XCTestCase {
  let sut = MainCameraView()
  let controllerInject = MainCameraController()
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    sut.mainCameraController = controllerInject
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testSwitchFlash1Time() {
    let expect = expectation(description: "Camera flash switchecd")
    sut.mainCameraController.flashModeSignal.observeValues({ (value) in
      expect.fulfill()
    })
    sut.mainCameraController.switchFlashMode()
    wait(for: [expect], timeout: 1.0)
  }
  func testSwitchFlash3Time() {
    let expect = expectation(description: "Camera flash switchecd")
    var timeHit = 0
    sut.mainCameraController.flashModeSignal.observeValues({ (value) in
      timeHit = timeHit + 1
      if(timeHit == 3){
        expect.fulfill()
      }
    })
    sut.mainCameraController.switchFlashMode()
    sut.mainCameraController.switchFlashMode()
    sut.mainCameraController.switchFlashMode()
    wait(for: [expect], timeout: 1.0)
  }
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
