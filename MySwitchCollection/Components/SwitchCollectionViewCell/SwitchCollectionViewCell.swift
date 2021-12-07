//
//  SwitchCollectionViewCell.swift
//  MySwitchCollection
//
//  Created by Gustavo Kumasawa on 30/09/21.
//

import UIKit

class SwitchCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var stemImage: UIImageView!
  @IBOutlet weak var topHousingImage: UIImageView!
  @IBOutlet weak var bottomHousingImage: UIImageView!
  
  @IBOutlet weak var stemImageCenterYConstraint: NSLayoutConstraint!
  
  static let identifier = "SwitchCollectionViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    stemImage.layer.zPosition = 3
    topHousingImage.layer.zPosition = 2
    bottomHousingImage.layer.zPosition = 1
  }
  
  public func configure(switchType: SwitchType) {
    var type: String
    
    if switchType == .kailh {
      type = "Kailh"
    } else {
      type = "Cherry"
    }
    
    stemImage.image = UIImage(named: "\(type)Stem")
    topHousingImage.image = UIImage(named: "\(type)TopHousing")
    bottomHousingImage.image = UIImage(
      named: "\(type)BottomHousing"
    )
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "SwitchCollectionViewCell", bundle: nil)
  }
}
