//
//  AddEditSwitchVC.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 01/10/21.
//

import UIKit
import CoreData

class AddEditSwitchVC: UIViewController {
  var switchData: Switch?
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var stemImage: UIImageView!
  @IBOutlet weak var topHousingImage: UIImageView!
  @IBOutlet weak var bottomHousingImage: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var switchTypeSwitch: UISwitch!
  @IBOutlet weak var stemColorButton: UIButton!
  @IBOutlet weak var topHousingColorButton: UIButton!
  @IBOutlet weak var bottomHousingColorButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!
  
  var saveButton: UIBarButtonItem!
  
  var switchComponentColorEditing: SwitchComponent = .stem
  
  var navigationBarTitle: String!
  
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  var addToList: (Switch) -> Void = {_ in ()}
  var removeFromList: (Switch) -> Void = {_ in ()}
  var updateItem: (Switch) -> Void = {_ in ()}
  var refreshCollection: () -> Void = {()}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if switchData == nil {
      saveButton = UIBarButtonItem(
        title: "Save",
        style: .plain,
        target: self,
        action: #selector(savePressed)
      )
    } else {
      saveButton = UIBarButtonItem(
        title: "Save",
        style: .plain,
        target: self,
        action: #selector(updatePressed)
      )
    }
    
    navigationItem.rightBarButtonItem = saveButton
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Cancel",
      style: .plain,
      target: self,
      action: #selector(cancelPressed)
    )
    
    nameTextField.autocorrectionType = .no
    nameTextField.borderStyle = .none
    
    let dismissKeyboardGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(self.dismissKeyboard (_:))
    )
    self.view.addGestureRecognizer(dismissKeyboardGesture)
    
    if switchData == nil {
      newSwitchStartConfig()
    } else {
      editSwitchStartConfig()
    }
  }
  
  @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
    nameTextField.resignFirstResponder()
  }
  
  @objc func savePressed() {
    let newSwitch = Switch(
      name: nameTextField.text!,
      type: switchTypeSwitch.isOn ? .kailh : .cherry
    )
    newSwitch.stemColor = stemImage.tintColor
    newSwitch.topHousingColor = topHousingImage.tintColor
    newSwitch.bottomHousingColor = bottomHousingImage.tintColor
    
    addToList(newSwitch)
    
    refreshCollection()
    
    dismiss(animated: true, completion: nil)
  }
  
  @objc func updatePressed() {
    let updatedSwitch = switchData!.copy()
    updatedSwitch.name = nameTextField.text!
    updatedSwitch.type = switchTypeSwitch.isOn ? .kailh : .cherry
    updatedSwitch.stemColor = stemImage.tintColor
    updatedSwitch.topHousingColor = topHousingImage.tintColor
    updatedSwitch.bottomHousingColor = bottomHousingImage.tintColor
    
    //    print(updatedSwitch.id)
    
    updateItem(updatedSwitch)
    
    refreshCollection()
    dismiss(animated: true, completion: nil)
  }
  
  @objc func cancelPressed() {
    dismiss(animated: true, completion: nil)
  }
  
  func newSwitchStartConfig() {
    navigationBarTitle = "New Switch"
    
    self.title = navigationBarTitle
    saveButton.isEnabled = false
    
    stemImage.tintColor = .gray
    topHousingImage.tintColor = .gray
    bottomHousingImage.tintColor = .gray
    
    switchTypeSwitch.isOn = false
    
    stemColorButton.setTitle("", for: .normal)
    stemColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    stemColorButton.layer.cornerRadius = 15
    stemColorButton.layer.backgroundColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    
    topHousingColorButton.setTitle("", for: .normal)
    topHousingColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    topHousingColorButton.layer.cornerRadius = 15
    topHousingColorButton.layer.backgroundColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    
    bottomHousingColorButton.setTitle("", for: .normal)
    bottomHousingColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    bottomHousingColorButton.layer.cornerRadius = 15
    bottomHousingColorButton.layer.backgroundColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    
    deleteButton.isEnabled = false
    deleteButton.alpha = 0
  }
  
  func editSwitchStartConfig() {
    navigationBarTitle = switchData?.name
    self.title = navigationBarTitle
    saveButton.isEnabled = true
    
    stemImage.tintColor = switchData?.stemColor
    topHousingImage.tintColor = switchData?.topHousingColor
    bottomHousingImage.tintColor = switchData?.bottomHousingColor
    
    nameTextField.text = navigationBarTitle
    
    changeSwitchType(to: switchData!.type)
    
    switchTypeSwitch.isOn = switchData?.type == .kailh ? true : false
    
    stemColorButton.setTitle("", for: .normal)
    stemColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    stemColorButton.layer.cornerRadius = 15
    stemColorButton.layer.backgroundColor = switchData?.stemColor.cgColor
    
    topHousingColorButton.setTitle("", for: .normal)
    topHousingColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    topHousingColorButton.layer.cornerRadius = 15
    topHousingColorButton.layer.backgroundColor = switchData?.topHousingColor.cgColor
    
    bottomHousingColorButton.setTitle("", for: .normal)
    bottomHousingColorButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    bottomHousingColorButton.layer.cornerRadius = 15
    bottomHousingColorButton.layer.backgroundColor = switchData?.bottomHousingColor.cgColor
    
    deleteButton.isEnabled = true
    deleteButton.alpha = 1
  }
  
  func startColorPicker(for switchComponent: SwitchComponent) {
    switchComponentColorEditing = switchComponent
    
    let picker = UIColorPickerViewController()
    
    switch switchComponent {
    case .stem:
      picker.selectedColor = stemImage.tintColor
    case .topHousing:
      picker.selectedColor = topHousingImage.tintColor
    case .bottomHousing:
      picker.selectedColor = bottomHousingImage.tintColor
    }
    
    picker.delegate = self
    self.present(picker, animated: true, completion: nil)
  }
  
  func checkIfCanSave() {
    if nameTextField.text != "" {
      saveButton.isEnabled = true
      return
    }
    
    saveButton.isEnabled = false;
  }
  
  func changeSwitchType(to switchType: SwitchType) {
    var switchName: String
    
    if switchType == .kailh {
      switchName = "Kailh"
    } else {
      switchName = "Cherry"
    }
    
    stemImage.image = UIImage(named: "\(switchName)Stem")
    topHousingImage.image = UIImage(named: "\(switchName)TopHousing")
    bottomHousingImage.image = UIImage(named: "\(switchName)BottomHousing")
  }
  
  @IBAction func onNameChange(_ sender: Any) {
    if nameTextField.text == "" {
      navigationBarTitle = "New Switch"
      self.title = navigationBarTitle
    } else {
      navigationBarTitle = nameTextField.text!
      self.title = navigationBarTitle
    }
    
    checkIfCanSave()
  }
  
  @IBAction func onSwitchTypeChange(_ sender: Any) {
    if switchTypeSwitch.isOn {
      changeSwitchType(to: .kailh)
    } else {
      changeSwitchType(to: .cherry)
    }
  }
  
  @IBAction func onStemColorPress(_ sender: Any) {
    startColorPicker(for: .stem)
  }
  
  @IBAction func onTopHousingColorPress(_ sender: Any) {
    startColorPicker(for: .topHousing)
  }
  
  @IBAction func onBottomHousingColorPress(_ sender: Any) {
    startColorPicker(for: .bottomHousing)
  }
  
  @IBAction func onDeletePress(_ sender: Any) {
    let alert = UIAlertController(title: "Are you sure?", message: "After deleting a switch it is impossible to recover it.", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
      self.removeFromList(self.switchData!)
      self.refreshCollection()
      self.dismiss(animated: true, completion: nil)
    }))
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
    self.present(alert, animated: true)
  }
}

