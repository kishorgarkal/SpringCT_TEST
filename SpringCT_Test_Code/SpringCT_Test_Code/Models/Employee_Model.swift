//
//  Employee_Model.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
struct Employee: Identifiable,Encodable,Decodable {
    var id = UUID()
    var name: String
    var age: Int
    var address: String
}
