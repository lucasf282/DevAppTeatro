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

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonLogOut = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: Selector("logout"))
        self.navigationItem.rightBarButtonItem  = buttonLogOut
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            self.navigationController?.viewControllers.remove(at: self.navigationController!.viewControllers.count-1)
            show(storyboard!.instantiateViewController(withIdentifier: "RegisterPageViewController"), sender: nil)
        } catch {
            print(error)
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
