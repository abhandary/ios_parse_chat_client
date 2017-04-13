//
//  ViewController.swift
//  ParseClient
//
//  Created by Akshay Bhandary on 4/12/17.
//  Copyright © 2017 AkshayBhandary. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var passedUser: PFUser?
    
    
    @IBAction func onLogin(_ sender: Any) {
        
        
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil {
                self.passedUser = user
                self.performSegue(withIdentifier: "successSegue", sender: self)
            }else{
                print(error!.localizedDescription)
            }
        }
        
    }
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
    
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error {
                let errorString = error.localizedDescription
                // Show the errorString somewhere and let the user try again.
                print(errorString)
                
            } else {
                self.passedUser = user
                self.performSegue(withIdentifier: "successSegue", sender: self)
                // Hooray! Let them use the app now.
            }
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successSegue" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.user = passedUser
            
        }
    }


}

