//
//  LoginController.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import UIKit
import SwiftUI
class LoginController: UIViewController {

    @IBOutlet weak var email_txt: UITextField!
    
    @IBOutlet weak var password_txt: UITextField!
    
    @IBOutlet weak var Signin_Btn: UIButton!
    
    @IBOutlet weak var error_message_lbl: UILabel!
  
    // MARK: - Stored Properties
    
    var loginViewModel: LoginViewModel! = LoginViewModel(loginManager: LoginManager())

   
    
       //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
             setDelegates()
               setupButton()
               bindData()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBActions
       @IBAction func loginButtonPressed(_ sender: UIButton) {
           //Here we ask viewModel to update model with existing credentials from text fields
           loginViewModel.updateCredentials(username: email_txt.text!, password: password_txt.text!)
           
           //Here we check user's credentials input - if it's correct we call login()
           switch loginViewModel.credentialsInput() {
               
           case .Correct:
               login()
           case .Incorrect:
               return
           }
       }
       
       
       func bindData() {
           self.loginViewModel.credentialsInputErrorMessage.bind { [weak self] in
               self?.error_message_lbl.isHidden = false
               self?.error_message_lbl.text = $0
           }
           
           self.loginViewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
               if $0, let textField = self?.email_txt {
                   self?.highlightTextField(textField)
               }
           }

           self.loginViewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
               if $0, let textField = self?.password_txt {
                   self?.highlightTextField(textField)
               }
           }
           
           self.loginViewModel.errorMessage.bind {
               guard let errorMessage = $0 else { return }
               //Handle presenting of error message (e.g. UIAlertController)
           }
       }
       
       
    func login() {
        // Retrieve email and password from text fields
        guard let email = email_txt.text, !email.isEmpty else {
            print("Email is empty")
            return
        }
        
        guard let password = password_txt.text, !password.isEmpty else {
            print("Password is empty")
            return
        }
        
        // Attempt login
        loginViewModel.login(email: email, password: password) { [weak self] success, error in
            guard let self = self else { return }
            if success {
                // Save login state
                self.saveLoginState()
                
                // Navigate to home screen
                self.navigateToHomeScreen()
            } else {
                // Login failed, handle error
                if let error = error {
                    // Assuming self.error_message_lbl is your UILabel instance
                    loginViewModel.credentialsInputErrorMessage.value = "Login failed with error: \(error.localizedDescription)"

                 //   print("Login failed with error: \(error.localizedDescription)")
                } else {
                    print("Login failed")
                }
            }
        }
    }
   
       
    func saveLoginState() {
        // Save user credentials securely (e.g., in Keychain or UserDefaults)
        // Example: Save a token or username
        UserDefaults.standard.set("true", forKey: "isUserLoggedin")
    }
    
    func navigateToHomeScreen() {
        // Navigate to home screen (assuming it's represented by a view controller named HomeViewController)
        let homeView = HomeView().navigationBarTitle("Home") // Customize navigation bar title if needed
               let hostingController = UIHostingController(rootView: homeView)
               navigationController?.pushViewController(hostingController, animated: true)
    }

       
       func setupButton() {
           Signin_Btn.layer.cornerRadius = 5
       }
       
       
       func setDelegates() {
           if let emailTextField = email_txt {
                  emailTextField.delegate = self
              } else {
                  print("Error: email_txt is nil")
              }
              
              if let passwordTextField = password_txt {
                  passwordTextField.delegate = self
              } else {
                  print("Error: password_txt is nil")
              }
       }
       
       
       func highlightTextField(_ textField: UITextField) {
           textField.resignFirstResponder()
           textField.layer.borderWidth = 1.0
           textField.layer.borderColor = UIColor.red.cgColor
           textField.layer.cornerRadius = 3
       }
   }


   //MARK: - Text Field Delegate Methods
   extension LoginController: UITextFieldDelegate {
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           email_txt.resignFirstResponder()
           password_txt.resignFirstResponder()
           return true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           error_message_lbl.isHidden = true
           email_txt.layer.borderWidth = 0
           password_txt.layer.borderWidth = 0
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


//extension LoginController {
//    static func create(with service: SomeService) -> UIViewController {
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
//        viewController.service = service
//        return viewController
//    }
//}
