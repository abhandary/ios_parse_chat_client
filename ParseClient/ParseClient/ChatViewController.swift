//
//  ChatViewController.swift
//  ParseClient
//
//  Created by Kevin Thrailkill on 4/12/17.
//  Copyright © 2017 AkshayBhandary. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ChatViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var messageTextField: UITextField!
    var user: PFUser?
    var image: UIImage?
    
    
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
        if let image = image {
            msg["photo"] = PFFile(data: UIImagePNGRepresentation(image)!)
        }

        msg.saveInBackground { (success, error) in
            if success {
                print(msg)
                self.messageTextField.text = ""
                
                
            } else {
                print(error!.localizedDescription)
            }
        }
        image = nil
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }

        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        let size = CGSize(width: 100.0, height: 100.0)
        
        
        // Scale image to fit within specified size while maintaining aspect ratio
        let aspectScaledToFitImage = originalImage.af_imageAspectScaled(toFit: size)
        
       image = aspectScaledToFitImage
        
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
