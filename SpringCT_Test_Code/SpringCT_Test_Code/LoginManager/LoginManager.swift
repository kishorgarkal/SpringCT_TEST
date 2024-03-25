//
//  LoginManager.swift
//  SpringCT_Test_Code
//
//  Created by kishor garkal on 25/03/24.
//

import Foundation


class LoginManager {
  
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        // Construct the request body string
        let requestBodyString = "email=\(email)&password=\(password)"
        
        // Convert the request body string to data
        guard let requestBodyData = requestBodyString.data(using: .utf8) else {
            completion(false, NSError(domain: "RequestErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request body"]))
            return
        }
        
        // Replace the following code with your actual API call
        let url = URL(string: BASE_URL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBodyData
        
        // Create a URLSession task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response from the server
            if let error = error {
                // Handle network error
                completion(false, error)
                return
            }
            
            // Check if the server returned a successful response (status code 200-299)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(false, NSError(domain: "InvalidResponseDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server response"]))
                return
            }
            
            // Ensure that data is not nil
            guard let responseData = data else {
                completion(false, NSError(domain: "InvalidResponseDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response data"]))
                return
            }
            
            // Parse the response JSON into the LoginResponse model
            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginResponse.self, from: responseData)
                
                // Check if the received token matches the expected token
                if loginResponse.token == "QpwL5tke4Pnpja7X4" {
                    // Login successful
                    completion(true, nil)
                } else {
                    // Login failed
                    completion(false, NSError(domain: "LoginErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login failed"]))
                }
            } catch {
                // Error decoding JSON
                completion(false, error)
            }
        }
        
        // Start the URLSession task
        task.resume()
    }
}
