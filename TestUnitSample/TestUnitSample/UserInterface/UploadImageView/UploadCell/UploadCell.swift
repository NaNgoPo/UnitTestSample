//
//  UploadCell.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Photos
class UploadCell: UICollectionViewCell {
  @IBOutlet weak var imageCenter: UIImageView!
  var thumbnailImage:UIImage?
  var currentAsset:PHAsset?// save the value for full images request
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  func setData(asset:PHAsset,withHightLight:Bool){
    currentAsset = asset
    if(withHightLight){
      self.backgroundColor = UIColor.red
    }else{
      self.backgroundColor = UIColor.white
    }
    if(asset.mediaType == .image){
      PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 50, height: 50), contentMode: .default, options: nil) { [weak self] (image, [AnyHashable : Any]?) in
        guard let self = self else{
          return
        }
        self.thumbnailImage = image
        self.imageCenter.image = self.thumbnailImage
      }
    }
  }
}
