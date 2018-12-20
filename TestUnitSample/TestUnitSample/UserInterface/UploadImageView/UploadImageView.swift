//
//  UploadImageView.swift
//  CamVideoRecord
//
//  Created by East Agile on 12/19/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import Photos

class UploadImageView: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  private let uploadingImageController = UploadImageController()
  @IBOutlet weak var collectionViewMain: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionViewMain.register(UINib.init(nibName: "UploadCell", bundle: nil), forCellWithReuseIdentifier: "UploadCell")
    let observerFetchLayout = Signal<PHFetchResult<PHAsset>, FetchError>.Observer{ [weak self] event in
      guard let self = self else{
        return
      }
      switch event {
      case let .value(_):
        print("getAllimages in view")
        DispatchQueue.main.async {
           self.collectionViewMain.reloadData()
        }
       
      case let .failed(_):
        print("error")
      default:
        break
      }
    }
    self.uploadingImageController.imageFetchSignal.observe(observerFetchLayout)
  }
  @IBAction func buttonCancelDidPressed(_ sender: Any) {
    self.dismiss(animated: true) {
      //Do additional thing after back
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.uploadingImageController.fetchAllImages()
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let assetFound = uploadingImageController.viewModel.assetFounded else {
      return 0
    }
    return assetFound.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
    if let assetFound = uploadingImageController.viewModel.assetFounded?.object(at: indexPath.row){
      let needHighLight = self.uploadingImageController.viewModel.listOfChooseImages.contains(indexPath.row)
      cell.setData(asset: assetFound,withHightLight:needHighLight)
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    uploadingImageController.requestProcessTap(index: indexPath.row)
    collectionView.reloadData()
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var size = collectionView.frame.size
    size.width = size.width / 4.0
    size.height = size.height / 2.0
    return size
  }
}
