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
    
    
    var chatArray : [PFObject] = []
    
    @IBOutlet weak var chatTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user)

        
        
        chatTableView.estimatedRowHeight = 44
        chatTableView.rowHeight = UITableViewAutomaticDimension

        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let query = PFQuery(className:"AkshayKevinMessage")
            let str = self.user!.username! as NSString
            // query.whereKey("user", equalTo: str)
            query.includeKey("user")
            query.addDescendingOrder("createdAt")
            
            query.findObjectsInBackground(block: { (msgs, error) in
                if msgs != nil {
                    self.chatArray = msgs!
                    self.chatTableView.reloadData()
                }
            })
            
            
        }
        
        

        // Do any additional setup after loading the view.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func composeClicked(_ sender: AnyObject) {
        
        let msg = PFObject(className:"AkshayKevinMessage")
        msg["user"] = user!.username!
        msg["text"] = messageTextField.text!


        msg.saveInBackground { (success, error) in
            if success {
                print(msg)
                self.messageTextField.text = ""
            } else {
                print(error!.localizedDescription)
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

extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) 
        
        let msg = chatArray[indexPath.row]
        
        
        cell.textLabel?.text = msg.object(forKey: "text") as? String
        cell.detailTextLabel?.text = msg.object(forKey: "user") as? String
        
        return cell
    }
    
    
    
    
    
    
    
}
