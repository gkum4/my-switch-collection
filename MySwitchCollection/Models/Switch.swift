//
//  Switch.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 28/09/21.
//

import UIKit
import CoreData

class Switch {
  var id: NSManagedObjectID!
  var name: String
  var type: SwitchType
  var stemColor: UIColor = .gray
  var topHousingColor: UIColor = .gray
  var bottomHousingColor: UIColor = .gray
//  var tags: [Tag] = []
//  var description: String = ""
//  var link: String = ""
  
  init(name: String, type: SwitchType) {
    self.name = name
    self.type = type
  }
  
  static func convertFromCoreData(_ data: NSManagedObject) -> Switch {
    let name = data.value(forKey: "name") as! String
    var type: SwitchType
    let stemColor = UIColor.getColor(
      from: data.value(forKey: "stemColor") as! String
    )!
    let topHousingColor = UIColor.getColor(
      from: data.value(forKey: "topHousingColor") as! String
    )!
    let bottomHousingColor = UIColor.getColor(
      from: data.value(forKey: "bottomHousingColor") as! String
    )!
    
    if data.value(forKey: "type") as! String == "Kailh" {
      type = .kailh
    } else {
      type = .cherry
    }
    
    let newSwitch = Switch(name: name, type: type)
    newSwitch.id = data.objectID
    newSwitch.stemColor = stemColor
    newSwitch.topHousingColor = topHousingColor
    newSwitch.bottomHousingColor = bottomHousingColor
    return newSwitch
  }
  
  static func convertForCoreData(
    _ data: Switch,
    entity: NSEntityDescription,
    insertInto managedContext: NSManagedObjectContext
  ) -> NSManagedObject {
    let newData = NSManagedObject(entity: entity, insertInto: managedContext)
    newData.setValue(data.name, forKey: "name")
    newData.setValue(
      data.type == .kailh ? "Kailh" : "Cherry",
      forKey: "type"
    )
    newData.setValue(UIColor.getString(from: data.stemColor), forKey: "stemColor")
    newData.setValue(UIColor.getString(from: data.topHousingColor), forKey: "topHousingColor")
    newData.setValue(UIColor.getString(from: data.bottomHousingColor), forKey: "bottomHousingColor")
    
    return newData
  }
  
  func copy() -> Switch {
    let newSwitch = Switch(name: self.name, type: self.type)
    newSwitch.id = self.id
    newSwitch.stemColor = self.stemColor
    newSwitch.topHousingColor = self.topHousingColor
    newSwitch.bottomHousingColor = self.bottomHousingColor
    
    return newSwitch
  }
}

enum SwitchType {
  case cherry
  case kailh
}

enum SwitchComponent {
  case stem
  case topHousing
  case bottomHousing
}
