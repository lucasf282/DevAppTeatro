//
//  LoginViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/9/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)*/
    }
    
    @objc func dismissKeyboard(){
        //textField.resignFirstResponder()
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        // Try to create a account
        Auth.auth().signIn(withEmail: userEmail ?? "", password: userPassword ?? ""){(user, error) in
            if user != nil{
                print("user has signed up!")
            }
            if error != nil {
                if error != nil {
                    self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
                }
            }
        }
    }
    
    @IBAction func recuperarSenha() {
        Auth.auth().sendPasswordReset(withEmail: userEmailTextField.text ?? "") { (error) in
            self.displayMyAlertMessage(userMessage: error?.localizedDescription ?? error.debugDescription)
        }
    }
    @IBAction func cancelar(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func signinErrorMessage(){
        let myAlert = UIAlertController(title: "Alert", message: "Email ou senha errado", preferredStyle: UIAlertControllerStyle.alert)
        
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
