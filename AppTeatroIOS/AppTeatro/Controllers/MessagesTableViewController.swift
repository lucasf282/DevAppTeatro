//
//  MessagesTableViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 12/11/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MessagesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var MessageTable: UITableView!
    var chat: Chat?
    var messages: [ChatMessage] = [ChatMessage]()
    var chatRef: DatabaseReference!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MessageTable.tableFooterView = UIView()
        chatRef = Database.database().reference().child(chat!.nome!)
        chatRef.observe(.value, with: { (snapshot) -> Void in
            self.chat?.messages.removeAll()
            for message in snapshot.children.allObjects as! [DataSnapshot]{
                self.chat?.messages.append(ChatMessage(dict: (message.value as? [String: Any])!)!)
            }
            self.MessageTable.reloadData()
        })
    }

    @IBAction func SendAction(_ sender: Any) {
        guard let messageText = messageTextField.text else { return }
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        messageTextField.text = ""
        let reference = Database.database().reference().child(chat!.nome!)
        
        let message = [
                        "messageText":messageText,
                        "messageTime":Int(Date().timeIntervalSince1970),
                        "messageUser": userName
            ] as [String : Any]
        
        reference.childByAutoId().setValue(message)
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = chat?.messages.count{
            return count
        }
        return 0
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        // 9  de espaçamento interno da textview
//        let largura = tableView.frame.size.width - 49
//        //print(" tableview \(largura)")
//        
//        if let messageText = chat?.messages[indexPath.section].messageText{
//            let altura = messageText.height(withConstrainedWidth: largura, font: UIFont.systemFont(ofSize: 14))+8+24
//            print(" altura \(altura)")
//            return altura
//        }else{
//            let altura = "asdf".height(withConstrainedWidth: largura, font: UIFont.systemFont(ofSize: 14))+8+24
//            print(" altura \(altura)")
//            return altura
//        }
//        // 8 de espaçamento da celula
//        // 24 de espaçamento interno da textView
//}
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        cell.lbl_usuario.text = chat?.messages[indexPath.row].messageUser
        cell.lbl_data.text = formatter.string(from: Date(timeIntervalSince1970: Double(chat?.messages[indexPath.row].messageTime ?? 0)))
        cell.textView_menssagem.text = chat?.messages[indexPath.row].messageText

        return cell
    }
}
