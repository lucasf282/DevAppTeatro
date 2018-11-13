//
//  ChatsTableViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 08/11/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase

class ChatsTableViewController: UITableViewController{
    var databaseRoot: DatabaseReference!
    var chat: Chat?
    var chatArray: [Chat] = [Chat]()
    let messagesSegue = "ChatsToMessagesSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView() //evita aparecer o separador em linhas vazias
        databaseRoot = Database.database().reference().root
        databaseRoot?.observe(.value, with: { (snapshot) -> Void in
            
            for chat in snapshot.children.allObjects as! [DataSnapshot]{
                let chatName = chat.key
                let messages = chat.value as? [String: Any]
                self.chatArray.append(Chat(nome: chatName, messages: messages))
            }
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath)

        cell.textLabel?.text = chatArray[indexPath.row].nome

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chat = self.chatArray[indexPath.row]
        self.performSegue(withIdentifier: messagesSegue, sender: nil)
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case messagesSegue:
            return self.chat != nil
        default:
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case messagesSegue:
                (segue.destination as! MessagesTableViewController).chat = self.chat
                self.chat = nil
            default:
                break;
            }
        }
    }
}
