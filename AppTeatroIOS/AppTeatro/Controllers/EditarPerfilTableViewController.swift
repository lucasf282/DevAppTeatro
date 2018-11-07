//
//  EditarPerfilTableViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 03/11/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditarPerfilTableViewController: UITableViewController {

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var txtf_nome: UITextField!
    @IBOutlet weak var txtf_email: UITextField!
    @IBOutlet weak var txtf_senha: UITextField!
    var txtf_telefone: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView() //evita aparecer o separador em linhas vazias
        if Auth.auth().currentUser != nil{
           txtf_nome.text = Auth.auth().currentUser?.displayName
            txtf_email.text = Auth.auth().currentUser?.email
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func atualizarPerfil() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = txtf_nome.text
        changeRequest?.commitChanges { (error) in
            self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
        }
        Auth.auth().currentUser?.updateEmail(to: txtf_email.text ?? "") { (error) in
            self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
        }
        Auth.auth().currentUser?.updatePassword(to: txtf_senha.text ?? "") { (error) in
            self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
        }
    }
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion:nil)
    }
}
