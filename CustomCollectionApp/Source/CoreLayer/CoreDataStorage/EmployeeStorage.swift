//
//  EmployeeStorage.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 14.11.2022.
//
//
import UIKit
import CoreData

protocol EmployeeStorageMainFunctional: AnyObject {
    func getAllItems() -> [Employee]
    func save(items: [Employee])
    func deleteAllItems()
    var isEmpty: Bool { get }
}

final class EmployeeStorage {
    
    // MARK: - Properties
    
    static let shared = EmployeeStorage()
    private var employeeList = [Employee]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

// MARK: - EmployeeStorageMainFunctional

extension EmployeeStorage: EmployeeStorageMainFunctional {
    func getAllItems() -> [Employee] {
        do {
            let list = try context.fetch(EmployeeEntity.fetchRequest())
            employeeList = list.map({mapToEntity(item: $0)})
        } catch {
            print("\(Constants.fetchErrorText) \(error.localizedDescription)")
        }
        
        return employeeList
    }
    
    func save(items: [Employee]) {
        for person in items {
            let newItem = EmployeeEntity(context: context)
            newItem.employeeName = person.name
            newItem.phoneNumber = person.phoneNumber
            newItem.skills = person.skills.joined(separator: Constants.separatorText)
            
            do {
                try context.save()
            } catch {
                print("\(Constants.saveErrorText) \(error.localizedDescription)")
            }
        }
    }
    
    var isEmpty: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
            let count  = try context.count(for: request)
            
            return count == .zero
        } catch {
            return true
        }
    }
    
    func deleteAllItems() {
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: EmployeeEntity.fetchRequest())
        do {
            _ = try context.execute(deleteRequest)
            as? NSBatchDeleteResult
            try context.save()
        } catch {
            print("\(Constants.deleteErrorText) \(error.localizedDescription)")
        }
    }
}

// MARK: - Mapping

private extension EmployeeStorage {
    func mapToEntity(item: EmployeeEntity) -> Employee {
        guard let skills = item.skills,
              let number = item.phoneNumber,
              let name = item.employeeName else { return Employee(name: Constants.mockText,
                                                                  phoneNumber: Constants.mockText,
                                                                  skills: [Constants.mockText]) }
        let model = Employee.init(name: name,
                                  phoneNumber: number,
                                  skills: [skills])
        
        return model
    }
}

// MARK: - Constants

private extension EmployeeStorage {
    enum Constants {
        static let separatorText: String = ", "
        static let entityName: String = "EmployeeEntity"
        static let mockText: String = ""
        static let fetchErrorText: String = "Failed to fecth list from sotrage, error:"
        static let saveErrorText: String = "Failed to save employee list to storage, error:"
        static let deleteErrorText: String = "Failed to batch delete employee data from storage, error:"

    }
}
