//
//  MainVCDataSource.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 28/09/21.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension MainVC {
  // 1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    var addToDivision = 0
    
    if switches.count % Int(itemsPerColumn) != 0 {
      addToDivision = 1
    }
    
    return (switches.count / Int(itemsPerColumn)) + addToDivision
  }
  
  // 2
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    let numberOfPreviousItems = section * Int(itemsPerColumn)
    
    if switches.count - numberOfPreviousItems < Int(itemsPerColumn) {
      return switches.count - numberOfPreviousItems
    }
    
    return Int(itemsPerColumn)
  }
  
  // 3
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as! SwitchCollectionViewCell
    
    let itemIndex = indexPath[0] * Int(itemsPerColumn) + indexPath[1]
    
    let stemColor = self.switches[itemIndex].stemColor
    let bottomHousingColor = self.switches[itemIndex].bottomHousingColor
    let topHousingColor = self.switches[itemIndex].topHousingColor
    
    cell.configure(switchType: self.switches[itemIndex].type)
    cell.stemImage.tintColor = stemColor
    cell.topHousingImage.tintColor = topHousingColor
    cell.bottomHousingImage.tintColor = bottomHousingColor
    
    return cell
  }
}

