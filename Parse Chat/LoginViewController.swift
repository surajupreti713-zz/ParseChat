//
//  ViewController.swift
//  Parse Chat
//
//  Created by Suraj Upreti on 2/24/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupMethod(_ sender: UIButton){
        let user = PFUser()
        user.username = usernameLabel.text
        user.password = passwordLabel.text
        user.email = emailLabel.text
        
        user.signUpInBackground {(succeeded: Bool, error: Error?)-> Void in
            if let error = error {
                let errorMessage = error.localizedDescription
                let alertController = UIAlertController(title: "Oops!", message: "\(errorMessage)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("Success")
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
    }
    
    @IBAction func loginMethod(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: "\(usernameLabel.text!)", password: "\(passwordLabel.text!)") { (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print ("logged in successfully")
                self.performSegue(withIdentifier: "login", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
                let alertController = UIAlertController(title: "Login Failed", message: "Invalid Username/Password", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }


}

