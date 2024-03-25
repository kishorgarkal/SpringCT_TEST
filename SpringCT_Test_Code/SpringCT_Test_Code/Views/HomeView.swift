//
//  HomeViewController.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import UIKit
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var isRefreshing = false
    @State private var isAddEmployeeScreenPresented = false // This state is local to HomeView
    @State private var shouldRefresh = false // State to trigger the refresh

    var body: some View {
        NavigationView {
           
                   List {
                       ForEach(viewModel.employees) { employee in
                           EmployeeRowView(employee: employee)
                       }
                   }
                   .navigationTitle("Employees")
                   .refreshable {
                        refreshData()
                   }
                   .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button(action: {
                               isAddEmployeeScreenPresented = true
                           }) {
                               Label("Add Employee", systemImage: "plus")
                           }
                       }
                   }
                   .background(
                       NavigationLink(destination: AddEmployeeView(viewModel: AddEmployeeViewModel(), isPresented: $isAddEmployeeScreenPresented, shouldRefresh: $shouldRefresh), isActive: $isAddEmployeeScreenPresented) {
                           EmptyView()
                       }
                   )
                   .onChange(of: shouldRefresh) { _ in
                       // Refresh data when shouldRefresh changes
                       if shouldRefresh {
                           refreshData()
                           shouldRefresh = false // Reset shouldRefresh after refreshing
                       }
                   }
               }
        Text("Please Pull to Refresh to see updated Data") // Header text
            .font(.callout)
                           .padding(.bottom, 10)
        .onAppear {
            viewModel.employees = loadEmployeesFromUserDefaults()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            viewModel.employees = loadEmployeesFromUserDefaults()
        }
    }
    
  
    @MainActor
    func refreshData() {
        Task {
            isRefreshing = true
            viewModel.employees = loadEmployeesFromUserDefaults()
            isRefreshing = false
        }
    }

    struct EmployeeRowView: View {
        let employee: Employee
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(employee.name)
                    .font(.headline)
                Text("Age: \(employee.age), Address: \(employee.address)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
