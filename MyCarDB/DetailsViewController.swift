//
//  DetailsViewController.swift
//  MyCarDB
//
//  Created by Артур on 29.12.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var carImageVIew: UIImageView!
    
    @IBOutlet weak var changeImageButton: UIButton!
    
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    @IBOutlet weak var producerLabel: UILabel!
    
    @IBOutlet weak var producerTextField: UITextField!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var yearPickerView: UIDatePicker!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setupSaveButton()
        setupImageView()
    }
    


    private func setupSaveButton() {
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderColor = saveButton.tintColor.cgColor
        saveButton.layer.borderWidth = 1
    }
    
    private func setupImageView() {
        carImageVIew.layer.cornerRadius = 10
    }
}
