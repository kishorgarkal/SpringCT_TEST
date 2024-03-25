//
//  CommonFunction.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import SwiftUI
func loadEmployeesFromUserDefaults()-> [Employee] {
    var employees = [Employee]()
    if let data = UserDefaults.standard.data(forKey: "EmployeeEntity") {
        if let decodedEmployees = try? JSONDecoder().decode([Employee].self, from: data) {
            employees = decodedEmployees
        }
    }
    return employees
}

func validateEmail(_ email: String) -> Bool {
    // Basic email validation, you can customize it as per your requirements
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

func validatePassword(_ password: String) -> Bool {
    // Basic password validation, you can customize it as per your requirements
    return password.count >= 6
}
