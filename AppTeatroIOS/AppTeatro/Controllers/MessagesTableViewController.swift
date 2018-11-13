//
//  MessagesTableViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 12/11/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    var chat: Chat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = chat?.messages.count{
            return count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 9  de espaçamento interno da textview
        let largura = tableView.frame.size.width - 49
        //print(" tableview \(largura)")
        
        if let messageText = chat?.messages[indexPath.section].messageText{
            let altura = messageText.height(withConstrainedWidth: largura, font: UIFont.systemFont(ofSize: 14))+8+24
            return altura
        }else{
            let altura = "".height(withConstrainedWidth: largura, font: UIFont.systemFont(ofSize: 14))+8+24
            return altura
        }
        // 8 de espaçamento da celula
        // 24 de espaçamento interno da textView
        //print(" altura \(altura)")
}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell

        cell.lbl_usuario.text = chat?.messages[indexPath.row].messageUser
        cell.lbl_data.text = String(describing: chat?.messages[indexPath.row].messageTime ?? 0)
        cell.textView_menssagem.text = chat?.messages[indexPath.row].messageText

        return cell
    }
}
