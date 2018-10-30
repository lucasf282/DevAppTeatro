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
        if Auth.auth().currentUser?.uid != nil {
            viewControllers.remove(at: viewControllers.count-1)
            show(storyboard!.instantiateViewController(withIdentifier: "MeuPerfilViewController"), sender: nil)
        }
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
