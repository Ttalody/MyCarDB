//
//  ViewController.swift
//  MyCarDB
//
//  Created by Артур on 27.12.2023.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet weak var carListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carListCollectionView.delegate = self
        carListCollectionView.dataSource = self
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarItemCollectionViewCell.identifier, for: indexPath) as? CarItemCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CarListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height/3.5)
    }
}
