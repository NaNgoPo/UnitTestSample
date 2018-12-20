//
//  SwipeChoosen.swift
//  TestUnitSample
//
//  Created by East Agile on 12/20/18.
//  Copyright © 2018 East Agile. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift
enum ChoosenMode:Int{
  case Camera = 0
  case Photos = 1
}
class SwipeChoosen: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  let (swipeSignal, inputSwiftSignal) = Signal<ChoosenMode, NoError>.pipe()
  @IBOutlet weak var collectionMain: UICollectionView!
  let cellsForDaragging = ["","","Camera","Photo","",""]
  let seletedLeftIndex = 2
  let seletedRightIndex = 3
  let cellsDisplayOnscreen = 3
  var currentSelected = 0
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellsForDaragging.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeChoosenViewCell", for: indexPath) as! SwipeChoosenViewCell
    let isSelected = (indexPath.row == currentSelected)
    cell.setInfo(displayText: cellsForDaragging[indexPath.row],withSelected:isSelected)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //TODO:catching this case
    if((indexPath.row == seletedLeftIndex) || (indexPath.row == seletedRightIndex)){
      self.moveToPosstion(index: indexPath.row)
    }
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.snapToCorrectPossition()
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = self.view.frame.size
    return CGSize(width: size.width / CGFloat(cellsDisplayOnscreen), height: size.height)
  }
  @IBOutlet weak var collectionViewMain: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewMain.register(UINib.init(nibName: "SwipeChoosenViewCell", bundle: nil), forCellWithReuseIdentifier: "SwipeChoosenViewCell")
  }
  func snapToCorrectPossition(){
    var currentOffset = collectionMain.contentOffset.x
    let size = self.view.frame.size
    let cellWidth = size.width / CGFloat(cellsDisplayOnscreen)
    currentOffset = currentOffset + cellWidth
    let maxOffset = cellWidth * CGFloat(cellsForDaragging.count)
    var moveTo = 0
    if(currentOffset > (maxOffset / 2.0)){ // snap to the Photos if over haft
      moveTo = seletedRightIndex
    }else{ // snap to the Photos if below haft
      moveTo = seletedLeftIndex
    }
    self.moveToPosstion(index: moveTo)
  }
  private func moveToPosstion(index:Int){
    self.currentSelected = index
    self.collectionViewMain.reloadData()
    if(index == seletedLeftIndex){
      inputSwiftSignal.send(value: ChoosenMode.Photos)
    }else{
      inputSwiftSignal.send(value: ChoosenMode.Camera)
    }
    DispatchQueue.main.async {
      self.collectionViewMain.scrollToItem(at: IndexPath.init(item: Int(index), section: 0), at: .centeredHorizontally, animated: true)
    }
  }
}
