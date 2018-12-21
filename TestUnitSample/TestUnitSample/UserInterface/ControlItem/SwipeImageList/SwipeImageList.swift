//
//  SwipeImageList.swift
//  TestUnitSample
//
//  Created by East Agile on 12/21/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import iCarousel
import Photos

class SwipeImageList: UIViewController,iCarouselDelegate,iCarouselDataSource {
  let IMAGE_TAG_VIEW = 1
  private var imageListAsset = [PHAsset]()
  @IBOutlet weak var carouselView: iCarousel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    carouselView.type = .rotary
  }
  func setListImage(assets:[PHAsset]){
    imageListAsset = assets
    carouselView.reloadData()
  }
  func numberOfItems(in carousel: iCarousel) -> Int {
    return imageListAsset.count
  }
  
  func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
    if let concreteView = view{
      //do stuff
      let asset = imageListAsset[index]
      if let imageView = view?.viewWithTag(IMAGE_TAG_VIEW) as? UIImageView{
        self.setInfo(imageView:imageView,asset:asset)
      }
      return concreteView
    }else{
      let centerTestView = UIView()
      let imageView = UIImageView()
      centerTestView.layer.borderWidth = 1
      centerTestView.layer.borderColor = UIColor.gray.cgColor
      centerTestView.addSubview(imageView)
      imageView.tag = IMAGE_TAG_VIEW
      imageView.frame = self.view.frame
      centerTestView.frame = self.view.frame
      centerTestView.layer.cornerRadius = 20
      centerTestView.clipsToBounds = true
      let asset = imageListAsset[index]
      self.setInfo(imageView:imageView,asset:asset)
      return centerTestView
    }
  }
  func setInfo(imageView:UIImageView,asset:PHAsset){
    PHImageManager.default().requestImage(for: asset, targetSize: imageView.frame.size, contentMode: .default, options: nil) { [weak self] (image,[AnyHashable : Any]?) in
      guard let self = self else{
        return
      }
      imageView.image = image
    }
  }
}
