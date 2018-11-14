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

class EditarPerfilTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var txtf_nome: UITextField!
    @IBOutlet weak var txtf_email: UITextField!
    @IBOutlet weak var txtf_senha: UITextField!
    @IBOutlet weak var txtf_telefone: UITextField!
    
    var caminho: String? = nil
    var imageURL: URL? = nil
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView() //evita aparecer o separador em linhas vazias
        
        guard let user = Auth.auth().currentUser else { return }
        txtf_nome.text = user.displayName
        txtf_email.text = user.email
        imgPerfil.loadImageUsingCacheWithURLString(user.photoURL?.absoluteString ?? "", placeHolder: UIImage(named: "login_icon"))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @IBAction func atualizarPerfil(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = txtf_nome.text
        changeRequest?.photoURL = imageURL
        
        changeRequest?.commitChanges { (error) in
            if(error != nil){
                self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
            }
        }
        Auth.auth().currentUser?.updateEmail(to: txtf_email.text ?? "") { (error) in
            if(error != nil){
                self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
            }
        }
        if (!txtf_senha.isEqual("")) && txtf_senha.text != nil{
            Auth.auth().currentUser?.updatePassword(to: txtf_senha.text ?? "") { (error) in
                if(error != nil){
                self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
                }
            }
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        if image != nil{
            guard let imageData = UIImagePNGRepresentation(image!) else {return}
            let profileImgReference = Storage.storage().reference().child("images").child("\(uid).png")
            profileImgReference.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.imageURL = URL(string: metadata?.path ?? "")
                    print(self.imageURL)
                    // Here you get the download url of the profile picture.
                }
            }
            changeRequest?.photoURL = imageURL
            changeRequest?.commitChanges { (error) in
                if(error != nil){
                    self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
                }
            }
        }
    }
    
    @IBAction func Capturarfoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Local da foto", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "camera", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion:nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgPerfil.image = image
        guard let caminho = info["UIImagePickerControllerImageURL"] as? URL else {
            return
        }
        self.caminho = caminho.absoluteString
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
