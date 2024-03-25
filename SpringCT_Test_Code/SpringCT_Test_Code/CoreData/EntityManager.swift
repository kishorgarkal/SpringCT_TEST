//
//  EntityManager.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import CoreData

class EmployeeEntity: Identifiable {
    // Define properties here that correspond to attributes in your Core Data model
    
       @NSManaged var id: UUID // Assuming id is of type UUID
       @NSManaged var name: String?
       @NSManaged var age: Int16
       @NSManaged var address: String?
}
