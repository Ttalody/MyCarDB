//
//  CoreDataManager.swift
//  MyCarDB
//
//  Created by Артур on 29.12.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func addItem(_ model: CarItemModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let car = CarModel(context: context)
        
        car.image = model.image.pngData()
        car.name = model.name
        car.producer = model.producer
        car.year = model.year
        car.color = model.color
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            context.rollback()
            completion(.failure(error))
        }
    }
    
    func fetchDataFromLocalStorage(completion: @escaping (Result<[CarModel], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = CarModel.fetchRequest()
        
        do {
            let cars = try context.fetch(request)
            completion(.success(cars))
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateItem(id: NSManagedObjectID, newItem: CarItemModel, completion: (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let carItem = try context.existingObject(with: id)
            carItem.setValue(newItem.name, forKey: "name")
            carItem.setValue(newItem.producer, forKey: "producer")
            carItem.setValue(newItem.image, forKey: "image")
            carItem.setValue(newItem.color, forKey: "color")
            carItem.setValue(newItem.year, forKey: "year")
            
            try context.save()
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func deleteItem(item: CarModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(item)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
}
