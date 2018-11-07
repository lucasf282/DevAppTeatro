//
//  MeuPerfilViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 21/07/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MeuPerfilViewController: UITableViewController {

    @IBOutlet weak var imagemPerfil: UIImageView!
    @IBOutlet weak var txt_nome: UILabel!
    @IBOutlet weak var txt_email: UILabel!
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.tabBarController?.navigationController?.popToRootViewController(animated: false)
        } catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView() //evita aparecer o separador em linhas vazias
        guard let user = Auth.auth().currentUser else { return }
        imagemPerfil.loadImageUsingCacheWithURLString(user.photoURL?.absoluteString ?? "", placeHolder: UIImage(named: "login_icon"))
        txt_nome.text = user.displayName
        txt_email.text = user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
