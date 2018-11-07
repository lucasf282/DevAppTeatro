//
//  RegisterPageViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 10/06/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterPageViewController: UIViewController, UITextFieldDelegate {

    let usuarioClassName = String(describing: Usuario.self)
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        //textField.resignFirstResponder()
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!){
            
            // Display alert message
            displayMyAlertMessage(userMessage: "Todos os campos devem sem preenchidos")
            return;
        }
        
        // Chech if password match
        if(userPassword != userRepeatPassword){
            // Display alert message
            displayMyAlertMessage(userMessage: "A senhas não correspondem")
            return;
        }
        
        // Try to create a account
        Auth.auth().createUser(withEmail: userEmail ?? "", password: userPassword ?? ""){(user, error) in
            if user != nil{
                self.signupSucessAlert()
            }
            if error != nil {
                self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
            }
        }
        
    }
    
    func signupSucessAlert(){
        let myAlert = UIAlertController(title: "Alert", message: "Sua conta foi criada com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default){
            action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion:nil)
    }
    
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion:nil)
    }

}
