//
//  UploadImageView.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit

class UploadImageView: UIViewController {
  private let uploadingImageController = UploadImageController()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func buttonCancelDidPressed(_ sender: Any) {
    self.dismiss(animated: true) {
      //Do additional thing after back
    }
  }
  override func viewDidAppear(_ animated: Bool) {
   self.uploadingImageController.fetchAllImages()
  }
}
