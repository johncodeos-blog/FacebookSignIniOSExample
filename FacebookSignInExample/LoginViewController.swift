//
//  LoginViewController.swift
//  FacebookSignInExample
//
//  Created by John Codeos on 3/23/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

/*
   Don't forget to add your own App ID and URL Scheme in Info.plist to test this app
*/

class LoginViewController: UIViewController {
    @IBOutlet var facebookLoginBtn: UIButton!
    
    var facebookId = ""
    var facebookFirstName = ""
    var facebookMiddleName = ""
    var facebookLastName = ""
    var facebookName = ""
    var facebookProfilePicURL = ""
    var facebookEmail = ""
    var facebookAccessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookLoginBtn.layer.cornerRadius = 10.0
        
//        // Login Button made by Facebook
//        let loginButton = FBLoginButton()
//        // Optional: Place the button in the center of your view.
//        loginButton.permissions = ["public_profile", "email"]
//        loginButton.delegate = self
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
        
        if isLoggedIn() {
            // Show the ViewController with the logged in user
        }else{
            // Show the Home ViewController
        }
        
        //Logout
//        LoginManager().logOut()
        
    }
    
    func isLoggedIn() -> Bool {
        let accessToken = AccessToken.current
        let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
        return isLoggedIn
    }
    
    @IBAction func facebookLoginBtnAction(_ sender: UIButton) {
        self.loginButtonClicked()
    }
    
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
        })
    }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]
                
                // Facebook Id
                if let facebookId = data["id"] as? String {
                    print("Facebook Id: \(facebookId)")
                    self.facebookId = facebookId
                } else {
                    print("Facebook Id: Not exists")
                    self.facebookId = "Not exists"
                }
                
                // Facebook First Name
                if let facebookFirstName = data["first_name"] as? String {
                    print("Facebook First Name: \(facebookFirstName)")
                    self.facebookFirstName = facebookFirstName
                } else {
                    print("Facebook First Name: Not exists")
                    self.facebookFirstName = "Not exists"
                }
                
                // Facebook Middle Name
                if let facebookMiddleName = data["middle_name"] as? String {
                    print("Facebook Middle Name: \(facebookMiddleName)")
                    self.facebookMiddleName = facebookMiddleName
                } else {
                    print("Facebook Middle Name: Not exists")
                    self.facebookMiddleName = "Not exists"
                }
                
                // Facebook Last Name
                if let facebookLastName = data["last_name"] as? String {
                    print("Facebook Last Name: \(facebookLastName)")
                    self.facebookLastName = facebookLastName
                } else {
                    print("Facebook Last Name: Not exists")
                    self.facebookLastName = "Not exists"
                }
                
                // Facebook Name
                if let facebookName = data["name"] as? String {
                    print("Facebook Name: \(facebookName)")
                    self.facebookName = facebookName
                } else {
                    print("Facebook Name: Not exists")
                    self.facebookName = "Not exists"
                }
                
                // Facebook Profile Pic URL
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                print("Facebook Profile Pic URL: \(facebookProfilePicURL)")
                self.facebookProfilePicURL = facebookProfilePicURL
                
                // Facebook Email
                if let facebookEmail = data["email"] as? String {
                    print("Facebook Email: \(facebookEmail)")
                    self.facebookEmail = facebookEmail
                } else {
                    print("Facebook Email: Not exists")
                    self.facebookEmail = "Not exists"
                }
                
                print("Facebook Access Token: \(token?.tokenString ?? "")")
                self.facebookAccessToken = token?.tokenString ?? ""
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "detailseg", sender: self)
                }
                
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailseg" {
            let DestView = segue.destination as! DetailsViewController
            DestView.facebookId = self.facebookId
            DestView.facebookFirstName = self.facebookFirstName
            DestView.facebookMiddleName = self.facebookMiddleName
            DestView.facebookLastName = self.facebookLastName
            DestView.facebookName = self.facebookName
            DestView.facebookProfilePicURL = self.facebookProfilePicURL
            DestView.facebookEmail = self.facebookEmail
            DestView.facebookAccessToken = self.facebookAccessToken
        }
    }
}

//extension LoginViewController: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if result?.isCancelled ?? false {
//            print("Cancelled")
//        } else if error != nil {
//            print("ERROR: Trying to get login results")
//        } else {
//            print("Logged in")
//            self.getUserProfile(token: result?.token, userId: result?.token?.userID)
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        // Do something after the user pressed the logout button
//        print("You logged out!")
//    }
//}
