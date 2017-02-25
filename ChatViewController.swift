//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Rajit Dang on 2/24/17.
//  Copyright © 2017 Rajit Dang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMesage(_ sender: Any) {
        var message = PFObject(className:"Message")
        message["text"] = chatField.text
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
