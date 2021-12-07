//
//  UIColor+.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 01/10/21.
//

import UIKit

extension UIColor {
  var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return (red, green, blue, alpha)
  }
  
  static func getString(from color: UIColor) -> String {
    let colorRGBA = color.rgba
    
    return "r:\(colorRGBA.red);g:\(colorRGBA.green);b:\(colorRGBA.blue);a:\(colorRGBA.alpha)"
  }
  
  static func getColor(from str: String) -> UIColor? {
    let arr = str.components(separatedBy: ";")
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    for i in 0..<arr.count {
      let type = arr[i].components(separatedBy: ":")[0]
      
      switch type {
      case "r":
        red = CGFloat(Float(arr[i].components(separatedBy: ":")[1])!)
      case "g":
        green = CGFloat(Float(arr[i].components(separatedBy: ":")[1])!)
      case "b":
        blue = CGFloat(Float(arr[i].components(separatedBy: ":")[1])!)
      case "a":
        alpha = CGFloat(Float(arr[i].components(separatedBy: ":")[1])!)
      default:
        return nil
      }
    }
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}
