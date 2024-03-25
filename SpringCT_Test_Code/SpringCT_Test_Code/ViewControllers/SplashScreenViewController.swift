//
//  SplashScreenViewController.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import UIKit
import SwiftUI

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLoggedinvalue = isLoggedIn()
        // Check if user is already logged in
        if isLoggedinvalue == "true" {
            // User is logged in, navigate to home screen
            navigateToHomeScreen()
        } else {
            // User is not logged in, navigate to login screen
            navigateToLoginScreen()
        }
    }
    
    func isLoggedIn() -> String {
        // Check if user credentials are saved (e.g., in Keychain or UserDefaults)
        // Return true if credentials are found, otherwise false
        // Example: check if a token or username is saved
        guard let isLoggedin = UserDefaults.standard.string(forKey: "isUserLoggedin") else { return "" }
        
        return isLoggedin
    }
    
    func navigateToHomeScreen() {
        // Navigate to home screen (assuming it's represented by a view controller named HomeViewController)
        let homeView = HomeView().navigationBarTitle("Home") // Customize navigation bar title if needed
               let hostingController = UIHostingController(rootView: homeView)
               navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func navigateToLoginScreen() {
        // Navigate to login screen (assuming it's represented by a view controller named LoginViewController)
      
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginController") as? LoginController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


