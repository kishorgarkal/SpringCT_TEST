//
//  HomeViewModel.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import SwiftUI
import CoreData


import Combine

class HomeViewModel: ObservableObject {
    @Published var employees: [Employee] = []
   // @Published var employeesentity: [EmployeeEntity] = []
    @Published var isAddEmployeeScreenPresented = false
    @State private var isRefreshing = false

    var navigateToAddEmployee: (() -> Void)?
    
    init() {
         employees = loadEmployeesFromUserDefaults()
        // Now you can use the 'employees' array retrieved from UserDefaults

    }
   
    
    func addEmployee() {
        // Call the closure to navigate to Add Employee Screen
        navigateToAddEmployee?()
    }
    
   
}


/* CoreData Implementation failed due to some Technical glitch so shifted to Userdefaults for Temporary Solution*/


//class HomeViewModel: ObservableObject {
//    @Published var employeesentity: [EmployeeEntity] = []
//    @Published var isAddEmployeeScreenPresented = false
//    @Published var employees: [Employee] = []
//    var navigateToAddEmployee: (() -> Void)?
//    
//    func addEmployee() {
//        // Call the closure to navigate to Add Employee Screen
//        navigateToAddEmployee?()
//    }



   
    
//    init() {
//        fetchEmployees()
//    }
//    
//    func fetchEmployees() {
//        let fetchRequest: NSFetchRequest<EmployeeEntity> = NSFetchRequest<EmployeeEntity>(entityName: "SpringCT_Test_Code")
//
//        do {
//            self.employees = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
//        } catch {
//            print("Error fetching employees: \(error)")
//        }
//    }


  
//}
