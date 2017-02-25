//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Suraj Upreti on 2/24/17.
//  Copyright © 2017 Suraj Upreti. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var messageTextLabel: UILabel!
    
    var textArray: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // for the cell to autoresize
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // timer that calls the method that is assigned to it in certain interval
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessages = PFObject(className: "Message")
        chatMessages["text"] = messageTextField.text
        chatMessages.saveInBackground(block: {(success: Bool?, error: Error?) in
            if success == true {
                print ("Message saved:\(chatMessages["text"]!)")
            }
            else {
                print("\(error)")
            }
        })
    }
    
    // called by the timer every 5 seconds
    func onTimer() {
        // Add code to be run periodically
        print("called")
        print ("*****************")
        let queryObj = PFQuery(className: "Message")
        queryObj.whereKeyExists("text")
        queryObj.order(byDescending: "createdAt")
        queryObj.findObjectsInBackground { (respondArray: [PFObject]?, error: Error?) in
            if error == nil {
                self.textArray = respondArray!
                self.tableView.reloadData()
                
            }
            else {
                print ("Error occured while retriving message")
                print ("\(error)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        //        cell.chatTextArray = textArray!
        //        cell.messageTextLabel = textArray?[indexPath.row]["text"]!
        cell.messageTextLabel.text = self.textArray?[indexPath.row].object(forKey: "text") as? String
        return cell
    }

}
