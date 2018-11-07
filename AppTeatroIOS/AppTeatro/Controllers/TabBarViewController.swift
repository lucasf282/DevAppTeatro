//
//  TabBarViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 07/10/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventosViewController = storyboard!.instantiateViewController(withIdentifier: "EventosNavVC")
        eventosViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let teatrosViewController = storyboard!.instantiateViewController(withIdentifier: "TeatrosTableVC")
        teatrosViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let meuPerfilViewController = storyboard!.instantiateViewController(withIdentifier: "MeuPerfilViewController")
        meuPerfilViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
    
        let loginViewController = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        var tabBarList:[UIViewController] = [eventosViewController, teatrosViewController]
        
        if Auth.auth().currentUser?.uid != nil {
            tabBarList.append(meuPerfilViewController)
        }else{
            tabBarList.append(loginViewController)
        }
        
        viewControllers = tabBarList
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
