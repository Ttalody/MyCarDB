//
//  ViewController.swift
//  MyCarDB
//
//  Created by Артур on 27.12.2023.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func reloadData()
}

final class CarListViewController: UIViewController {
    
    private var carsArray = [CarModel]()

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var carListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carListCollectionView.delegate = self
        carListCollectionView.dataSource = self
        carListCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.reloadData()
    }

    @IBAction func addButtonDidTap(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return }
        vc.loadView()
        vc.delegate = self
        vc.viewDidLoad()
        vc.setupVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CarListViewController: DetailsViewControllerDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            CoreDataManager.shared.fetchDataFromLocalStorage { [weak self] result in
                switch result {
                case .success(let cars): self?.carsArray = cars
                case .failure(let error): print(error.localizedDescription)
                }
            }
            
            self?.carListCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarItemCollectionViewCell.identifier, for: indexPath) as? CarItemCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(model: carsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return }
        vc.loadView()
        vc.viewDidLoad()
        vc.setupVC(model: carsArray[indexPath.row])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil,
                                                        previewProvider: nil) { [weak self] _ in
                    let deleteAction = UIAction(title: "Delete", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                        CoreDataManager.shared.deleteItem(item: self?.carsArray[indexPath.row] ?? CarModel()) { result in
                            switch result {
                            case .success(): self?.reloadData()
                            case .failure(let error): print(error.localizedDescription)
                            }
                        }
                    }
                    return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [deleteAction])
                }
                return config
            }
}
    


// MARK: - UICollectionViewDelegateFlowLayout

extension CarListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 20, height: view.bounds.height/3.5)
    }
}
