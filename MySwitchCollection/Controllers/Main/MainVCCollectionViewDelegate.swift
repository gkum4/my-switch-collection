//
//  MainVCCollectionViewDelegate.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 30/09/21.
//

import UIKit

extension MainVC {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {    
    collectionView.deselectItem(at: indexPath, animated: true)
    
    let itemIndex = indexPath[0] * Int(itemsPerColumn) + indexPath[1]
    
    let editSwitchVC = AddEditSwitchVC(nibName: "AddEditSwitchVC", bundle: nil)
    
    editSwitchVC.switchData = switches[itemIndex]
    
    editSwitchVC.removeFromList = removeSwitch
    
    editSwitchVC.updateItem = updateSwitch
    
    editSwitchVC.refreshCollection = {
      self.collectionView.reloadData()
    }

    let nav = UINavigationController(rootViewController: editSwitchVC)
    nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
    nav.navigationBar.shadowImage = UIImage()
    nav.navigationBar.isTranslucent = true

    self.present(nav, animated: true, completion: nil)
  }
}
