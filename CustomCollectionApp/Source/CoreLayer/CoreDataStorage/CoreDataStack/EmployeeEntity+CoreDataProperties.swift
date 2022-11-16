//
//  EmployeeEntity+CoreDataProperties.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 14.11.2022.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
    }

    @NSManaged public var skills: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var employeeName: String?
}

extension EmployeeEntity : Identifiable {

}
