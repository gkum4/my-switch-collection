//
//  AddEditSwitchVCColorPickerDelegate.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 01/10/21.
//

import UIKit

extension AddEditSwitchVC: UIColorPickerViewControllerDelegate {
  //  Called once you have finished picking the color.
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    switch switchComponentColorEditing {
    case .stem:
      stemImage.tintColor = viewController.selectedColor
      stemColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    case .topHousing:
      topHousingImage.tintColor = viewController.selectedColor
      topHousingColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    case .bottomHousing:
      bottomHousingImage.tintColor = viewController.selectedColor
      bottomHousingColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    }
  }
  
  //  Called on every color selection done in the picker.
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    switch switchComponentColorEditing {
    case .stem:
      stemImage.tintColor = viewController.selectedColor
      stemColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    case .topHousing:
      topHousingImage.tintColor = viewController.selectedColor
      topHousingColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    case .bottomHousing:
      bottomHousingImage.tintColor = viewController.selectedColor
      bottomHousingColorButton.layer.backgroundColor = viewController.selectedColor.cgColor
    }
  }
}
