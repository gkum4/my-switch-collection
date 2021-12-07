//
//  MainVCCoreDataOperations.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 02/10/21.
//

import UIKit
import CoreData

// Core Data CRUD operations
extension MainVC {
  func saveToCoreData(item: Switch) -> Switch {
    let managedContext = appDelegate!.persistentContainer.viewContext

    let entity = NSEntityDescription.entity(
      forEntityName: "SwitchEntity",
      in: managedContext
    )!
    
    let newSwitch = NSManagedObject(
      entity: entity,
      insertInto: managedContext
    )
    newSwitch.setValuesForKeys([
      "name": item.name,
      "type": item.type == .kailh ? "Kailh" : "Cherry",
      "stemColor": UIColor.getString(from: item.stemColor),
      "topHousingColor": UIColor.getString(from: item.topHousingColor),
      "bottomHousingColor": UIColor.getString(from: item.bottomHousingColor)
    ])
    
    do {
      try managedContext.save()
    } catch {
      print("Could not save switch. \(error)")
    }
    
    return Switch.convertFromCoreData(newSwitch)
  }
  
  func updateToCoreData(item: Switch) {
    let managedContext = appDelegate!.persistentContainer.viewContext
    
    do {
      let value = try managedContext.existingObject(
        with: item.id
      )
      
      value.setValuesForKeys([
        "name": item.name,
        "type": item.type == .kailh ? "Kailh" : "Cherry",
        "stemColor": UIColor.getString(from: item.stemColor),
        "topHousingColor": UIColor.getString(from: item.topHousingColor),
        "bottomHousingColor": UIColor.getString(from: item.bottomHousingColor)
      ])
      do {
        try managedContext.save()
      }
      catch {
        print(error)
      }
    } catch {
      print(error)
    }
  }
  
  func getAllFromCoreData() -> [Switch] {
    let managedContext = appDelegate!.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(
      entityName: "SwitchEntity"
    )
    
    do {
      let switches = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
      
      var arr: [Switch] = []
      
      switches.forEach { item in
        arr.append(Switch.convertFromCoreData(item))
      }
      
      return arr
    } catch {
      print(error)
    }
    
    return []
  }
  
  func deleteFromCoreData(item: Switch) {
    let managedContext = appDelegate!.persistentContainer.viewContext
    
    do {
      let value = try managedContext.existingObject(
        with: item.id
      )
      
      managedContext.delete(value)
      
      try managedContext.save()
    } catch {
      let saveError = error as NSError
      print(saveError)
    }
  }
}
