//
//  AddEmployeeViewModel.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import SwiftUI
import CoreData


class AddEmployeeViewModel: ObservableObject {
    @Published var name = ""
    @Published var age = ""
    @Published var address = ""
    
    let userDefaultsKey = "EmployeeEntity"
    
    func addEmployee(previousEmployees: [Employee]) {
        guard let age = Int(age) else {
            // Handle invalid age
            return
        }
        
        // Basic field validation
        guard !name.isEmpty, !address.isEmpty else {
            // Handle empty fields
            return
        }
        
        let newEmployee = Employee(name: name, age: age, address: address)
        
        // Append the new employee to the existing array
        var updatedEmployees = loadEmployeesFromUserDefaults()
        updatedEmployees.append(newEmployee)
        
        saveArrayToUserDefaults(employees: updatedEmployees)
        
        // Reset fields
        name = ""
        self.age = ""
        address = ""
    }
    
    func saveArrayToUserDefaults(employees: [Employee]) {
        let data = try? JSONEncoder().encode(employees)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
}

//Core DATA METHODS
/* //        let context = CoreDataStack.shared.persistentContainer.viewContext
 //        let employeeEntity = EmployeeEntity(context: context)
 //        employeeEntity.name = newEmployee.name
 //        employeeEntity.age = Int16(newEmployee.age)
 //        employeeEntity.address = newEmployee.address
         
 //        do {
 //            try context.save()
 //            // Optionally, you can notify any observers that the data has changed
 //            // For example, you could use NotificationCenter or Combine
 //        } catch {
 //            // Handle error while saving
 //            print("Error saving employee: \(error)")
 //        }*/

