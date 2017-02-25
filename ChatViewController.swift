//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Rajit Dang on 2/24/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages : [PFObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        print("timer fire")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMesage(_ sender: Any) {
        var message = PFObject(className:"Message")
        message["text"] = chatField.text
        message["user"] = PFUser.current()
        //message["user"] = PFUser.current()
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print("object was saved")
            } else {
                // There was a problem, check error.description
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = self.messages![indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        if let user = message["user"] as? PFUser {
            user.fetchInBackground(block: { (user, error) in
                if let user = user as? PFUser{
                    //print(user.username)
                    cell.usernameLabel.text = user.username
                }
            })
        } else {
            cell.usernameLabel.text = ""
        }
        return cell
    }
    
    func query() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                
                // The find succeeded.
                //print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                
                self.messages = objects
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                print(error?.localizedDescription)
            }
        }
    }
    
    func onTimer() {
        query()
        
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
