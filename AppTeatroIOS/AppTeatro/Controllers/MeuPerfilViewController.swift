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
            let loginViewController = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            loginViewController.tabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "ic_account_circle"), tag: 2)
            self.navigationController?.tabBarController?.viewControllers?[2] = loginViewController
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView() //evita aparecer o separador em linhas vazias
        guard let user = Auth.auth().currentUser else { return }
        imagemPerfil.loadImageUsingCacheWithURLString(user.photoURL?.absoluteString ?? "", placeHolder: UIImage(named: "login_icon"))
        txt_nome.text = user.displayName ?? user.email
        txt_email.text = user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
