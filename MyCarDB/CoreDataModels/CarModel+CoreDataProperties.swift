//
//  CarModel+CoreDataProperties.swift
//  MyCarDB
//
//  Created by Артур on 29.12.2023.
//
//

import Foundation
import CoreData


extension CarModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarModel> {
        return NSFetchRequest<CarModel>(entityName: "CarModel")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var producer: String?
    @NSManaged public var year: Date?
    @NSManaged public var color: String?

}

extension CarModel : Identifiable {

}
