//
//  MainVCSwitchList.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 02/10/21.
//

import UIKit

extension MainVC {
  func addNewSwitch(item: Switch) {
    let newSwitch = saveToCoreData(item: item)
    
    switches.append(newSwitch)
  }
  
  func updateSwitch(item: Switch) {
    updateToCoreData(item: item)
    
    let index = self.switches.firstIndex { searchItem in
      searchItem.id == item.id
    }!
    
    self.switches[index] = item
  }
  
  func removeSwitch(item: Switch) {
    deleteFromCoreData(item: item)
    
    let index = self.switches.firstIndex { searchItem in
      searchItem.id == item.id
    }!
    
    self.switches.remove(at: index)
  }
}

