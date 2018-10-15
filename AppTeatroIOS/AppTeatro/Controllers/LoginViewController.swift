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

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                print("error on signinup")
                self.signinErrorMessage()
            }
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
