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
    
    func setupCell(model: CarModel){
        guard let imageData = model.image else {return}
        self.carItemImageView.image = UIImage(data: imageData)
        self.carItemLabel.text = model.name
    }
}
