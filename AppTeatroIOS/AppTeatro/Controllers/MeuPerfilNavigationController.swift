//
//  MeuPerfilNavigationController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 10/10/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MeuPerfilNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var controllersStack = viewControllers
        controllersStack.remove(at: controllersStack.count-1)
        let loginViewController = storyboard!.instantiateViewController(withIdentifier: "RegisterPageViewController")
        let meuPerfilViewController = storyboard!.instantiateViewController(withIdentifier: "MeuPerfilViewController")
        setViewControllers(controllersStack, animated: true)
        if Auth.auth().currentUser?.uid != nil {
            show(meuPerfilViewController, sender: nil)
        }else{
            show(loginViewController, sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
