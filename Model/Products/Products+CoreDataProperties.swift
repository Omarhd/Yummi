//
//  Products+CoreDataProperties.swift
//  
//
//  Created by Omar Abdulrahman on 24/09/2022.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var qt: Int64

}
