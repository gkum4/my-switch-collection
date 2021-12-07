//
//  Tag.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 28/09/21.
//

import UIKit

class Tag: Identifiable {
  let id = UUID()
  var content: String
  
  init(content: String) {
    self.content = content
  }
}
