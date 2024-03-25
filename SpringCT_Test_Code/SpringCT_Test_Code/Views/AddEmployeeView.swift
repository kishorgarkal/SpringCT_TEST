//
//  AddEmployeeView.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import SwiftUI

struct AddEmployeeView: View {
    @ObservedObject var viewModel: AddEmployeeViewModel
    @Binding var isPresented: Bool // Binding to control the presentation from outside
    @State private var previousEmployees: [Employee] = []
    @Binding var shouldRefresh: Bool // Binding to trigger the refresh in HomeView
   
    var body: some View {
        VStack {
            Text("Add Employee") // Header text
                               .font(.title)
                               .padding(.bottom, 10)
            
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Age", text: $viewModel.age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Address", text: $viewModel.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.addEmployee(previousEmployees: previousEmployees)
            
                
                // Dismiss the sheet by updating the binding
                isPresented = false
            }) {
                Text("Add Employee")
            }
            .padding()
        }
        
        
    }
}
//struct AddEmployeeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEmployeeView(viewModel: AddEmployeeViewModel(), employees: Employee)
//    }
//}
