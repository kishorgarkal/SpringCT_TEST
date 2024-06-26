//
//  LoginViewModel.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation
import UIKit

class LoginViewModel {
    // MARK: - Stored Properties
    private let loginManager: LoginManager
    
    //Here our model notify that was updated
    private var credentials = Credentials() {
        didSet {
            username = credentials.username
            password = credentials.password
        }
    }
    
    private var username = ""
    private var password = ""
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
    }
    
    //Here we update our model
    func updateCredentials(username: String, password: String, otp: String? = nil) {
        credentials.username = username
        credentials.password = password
    }
    
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let credentialsStatus = credentialsInput()
        if credentialsStatus == .Correct{
            
            loginManager.login(email: email, password: password) { success, error in
                DispatchQueue.main.async {
                    completion(success, error)
                    
                }
            }
        }
    }
    
    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && password.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        if username.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            isUsernameTextFieldHighLighted.value = true
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty."
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        
       
               if !validateEmail(username) {
                   credentialsInputErrorMessage.value = "Invalid email format."
                   return .Incorrect
               }
               
               if !validatePassword(password) {
                   credentialsInputErrorMessage.value = "Password must be at least 6 characters long."
                   return .Incorrect
               }
               
               
           
        return .Correct
    }
}

extension LoginViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
