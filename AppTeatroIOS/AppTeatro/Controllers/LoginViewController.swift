//
//  LoginViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/9/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        if(userEmailStored == userEmail){
            if(userPasswordStored == userPassword){
                // Login is sucessfull
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                 UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
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
