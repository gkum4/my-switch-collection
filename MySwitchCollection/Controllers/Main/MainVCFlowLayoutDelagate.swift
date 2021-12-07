//
//  MainVCFlowLayoutDelagate.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 30/09/21.
//

import UIKit

// MARK: - Collection View Flow Layout Delegate
extension MainVC: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let squareWidth = isiPad ? 150 : 100
    
    return CGSize(width: squareWidth, height: squareWidth)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
