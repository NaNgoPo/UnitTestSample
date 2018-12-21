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
  
  let unHighlightColor = UIColor.white
  let highlightColor = UIColor.init(red: 204.0 / 255.0, green: 77.0 / 255.0, blue: 83.0 / 255.0, alpha: 1.0)

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  func setData(asset:PHAsset,withHightLight:Bool){
    currentAsset = asset
    if(withHightLight){
      self.backgroundColor = highlightColor
    }else{
      self.backgroundColor = unHighlightColor
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
