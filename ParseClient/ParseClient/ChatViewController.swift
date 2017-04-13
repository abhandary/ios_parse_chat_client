//
//  ChatViewController.swift
//  ParseClient
//
//  Created by Kevin Thrailkill on 4/12/17.
//  Copyright © 2017 AkshayBhandary. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user)

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func composeClicked(_ sender: AnyObject) {
        
        let msg = PFObject(className:"Message")
        msg["user"] = user!.username!
        msg["text"] = messageTextField.text!

        msg.saveInBackground { (success, error) in
            if success {
                print(msg);
            } else {
                print(error?.localizedDescription);
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
