//
//  DetailsViewController.swift
//  MyCarDB
//
//  Created by Артур on 29.12.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    static let identifier = "DetailsViewController"
    
    weak var delegate: CarListViewController?
    
    @IBOutlet weak var carImageVIew: UIImageView!
    
    @IBOutlet weak var changeImageButton: UIButton!
    
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    @IBOutlet weak var producerLabel: UILabel!
    
    @IBOutlet weak var producerTextField: UITextField!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var yearPickerView: UIDatePicker!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        
        setupSaveButton()
        setupImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    

    func setupVC(model: CarModel) {
        carImageVIew.image = UIImage(data: model.image ?? Data())
        modelTextField.text = model.name
        producerTextField.text = model.producer
        colorTextField.text = model.color
    }
    
    func setupVC() {
        carImageVIew.image = UIImage(named: "blankCar")
        modelTextField.text = ""
        producerTextField.text = ""
        colorTextField.text = ""
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        saveChanges()
    }
    
    @IBAction func changeImageButtonDidTap(_ sender: Any) {

        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    
    
    private func setupSaveButton() {
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderColor = saveButton.tintColor.cgColor
        saveButton.layer.borderWidth = 1
    }
    
    private func setupImageView() {
        carImageVIew.layer.cornerRadius = 10
    }
    
    private func saveChanges() {
        guard let image = self.carImageVIew.image,
              let name = self.modelTextField.text,
              let producer = self.producerTextField.text,
//              let year = Date(),
              let color = self.colorTextField.text
        else { return }
        let carItem = CarItemModel(image: image,
                                   name: name,
                                   producer: producer,
                                   year: Date(),
                                   color: color)
        
        CoreDataManager.shared.addItem(carItem) { result in
            switch result {
            case .success(): self.delegate?.reloadData()
                self.navigationController?.popViewController(animated: true)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    
    
}

extension DetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            carImageVIew.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
