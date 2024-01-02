//
//  DetailsViewController.swift
//  MyCarDB
//
//  Created by Артур on 29.12.2023.
//

import UIKit
import CoreData

final class DetailsViewController: UIViewController {
    
    static let identifier = "DetailsViewController"
    
    weak var delegate: CarListViewController?
    
    private var objectId: NSManagedObjectID?
    
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
        
    
        self.modelTextField.delegate = self
        self.producerTextField.delegate = self
        self.colorTextField.delegate = self

        setupGestureRecognizer()
        setupDatePicker()
        setupSaveButton()
        setupImageView()
    }

    func setupVC(model: CarModel) {
        carImageVIew.image = UIImage(data: model.image ?? Data())
        modelTextField.text = model.name
        producerTextField.text = model.producer
        colorTextField.text = model.color
        yearPickerView.date = model.year ?? Date()
        
        objectId = model.objectID
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
    
    private func setupDatePicker() {
        yearPickerView.datePickerMode = .date
        
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: currentDate)
        let minDateComponents = DateComponents(year: components.year! - 100, month: 1, day: 1)
        let maxDateComponents = DateComponents(year: components.year!, month: 12, day: 31)
        yearPickerView.minimumDate = calendar.date(from: minDateComponents)
        yearPickerView.maximumDate = calendar.date(from: maxDateComponents)

    }
    
    private func saveChanges() {
        guard let image = self.carImageVIew.image,
              let name = self.modelTextField.text,
              let producer = self.producerTextField.text,
              let color = self.colorTextField.text
        else { return }
        
        let carItem = CarItemModel(image: image,
                                   name: name,
                                   producer: producer,
                                   year: yearPickerView.date,
                                   color: color)
        
        if let id = objectId {
            CoreDataManager.shared.updateItem(id: id, newItem: carItem) { result in
                switch result {
                case .success(): self.navigationController?.popViewController(animated: true)
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
        else {
            CoreDataManager.shared.addItem(carItem) { result in
                switch result {
                case .success(): self.navigationController?.popViewController(animated: true)
                case .failure(let error): print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.dissmissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dissmissKeyboard() {
        self.view.endEditing(true)
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

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
