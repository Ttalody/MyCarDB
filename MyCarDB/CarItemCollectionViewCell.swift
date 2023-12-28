//
//  CarItemCollectionViewCell.swift
//  MyCarDB
//
//  Created by Артур on 27.12.2023.
//

import UIKit

class CarItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarItemCollectionViewCell"
    
    @IBOutlet weak var carItemImageView: UIImageView!
    
    @IBOutlet weak var carItemLabel: UILabel!
    
    func setupCell(name: String, image: UIImage){
        self.carItemImageView.image = image
        self.carItemLabel.text = name
    }
}
