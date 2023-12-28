//
//  ViewController.swift
//  MyCarDB
//
//  Created by Артур on 27.12.2023.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var carListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carListCollectionView.delegate = self
        carListCollectionView.dataSource = self
    }

    @IBAction func addButtonDidTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarItemCollectionViewCell.identifier, for: indexPath) as? CarItemCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(name: "blank", image: UIImage(imageLiteralResourceName: "blankCar"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        vc.loadView()
        if let image = UIImage(named: "blankCar") {
            vc.setupVC(image: image)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CarListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height/3.5)
    }
}
