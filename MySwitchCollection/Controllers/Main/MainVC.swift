//
//  MainVC.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 28/09/21.
//

import UIKit
import CoreData

final class MainVC: UICollectionViewController {
  let reuseIdentifier = SwitchCollectionViewCell.identifier
  var sectionInsets = UIEdgeInsets(
    top: 20,
    left: 20,
    bottom: 20,
    right: 20
  )
  var itemsPerColumn: CGFloat!
  var isiPad = false
  
  var switches: [Switch] = []
  
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    config()
  }
  
  func config() {
    collectionView.register(
      SwitchCollectionViewCell.nib(),
      forCellWithReuseIdentifier: SwitchCollectionViewCell.identifier
    )
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    collectionView.collectionViewLayout = layout
    collectionView.showsHorizontalScrollIndicator = false
    
    let screenHeight = UIScreen.main.bounds.height
    
    if screenHeight >= 1000 {
      isiPad = true
      
      itemsPerColumn = CGFloat(
        Int((screenHeight - 250) / 150)
      )
      sectionInsets = UIEdgeInsets(
        top: 30,
        left: 30,
        bottom: 30,
        right: 30
      )
    } else {
      itemsPerColumn = CGFloat(
        Int((screenHeight - 250) / 100)
      )
    }
    
    switches = getAllFromCoreData()
  }
  
  @IBAction func onPlusButtonPress(_ sender: Any) {
    let addSwitchVC = AddEditSwitchVC(nibName: "AddEditSwitchVC", bundle: nil)
    
    addSwitchVC.addToList = addNewSwitch
    addSwitchVC.refreshCollection = {
      self.collectionView.reloadData()
    }
    
    let nav = UINavigationController(rootViewController: addSwitchVC)
    nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
    nav.navigationBar.shadowImage = UIImage()
    nav.navigationBar.isTranslucent = true
    
    self.present(nav, animated: true, completion: nil)
  }
  
}

