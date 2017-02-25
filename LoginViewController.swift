//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Rajit Dang on 2/24/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let newUser = PFUser()
        // set user properties
        newUser.username = passwordField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
            }
        }
    }
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        let username = emailField.text ?? ""
        let password = passwordField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
