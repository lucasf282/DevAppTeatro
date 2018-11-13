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
        
        let teatrosViewController = storyboard!.instantiateViewController(withIdentifier: "TeatrosTableVC")
        teatrosViewController.tabBarItem = UITabBarItem(title: "Teatros", image: UIImage(named: "ic_account_balance"), tag: 0)
        
        let eventosViewController = storyboard!.instantiateViewController(withIdentifier: "EventosNavVC")
        eventosViewController.tabBarItem = UITabBarItem(title: "Eventos", image: UIImage(named: "FavoriteFilledIcon"), tag: 1)
        
        let meuPerfilViewController = storyboard!.instantiateViewController(withIdentifier: "MeuPerfilViewController")
        meuPerfilViewController.tabBarItem = UITabBarItem(title: "Meu Perfil", image: UIImage(named: "ic_account_circle"), tag: 2)
        
        let loginViewController = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        loginViewController.tabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "ic_account_circle"), tag: 2)
        
        let ChatViewController = storyboard!.instantiateViewController(withIdentifier: "ChatNavVC")
        ChatViewController.tabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "FavoriteFilledIcon"), tag: 3)
        
        var tabBarList:[UIViewController] = [teatrosViewController, eventosViewController]
        
        if Auth.auth().currentUser?.uid != nil {
            tabBarList.append(meuPerfilViewController)
        }else{
            tabBarList.append(loginViewController)
        }
        tabBarList.append(ChatViewController)
        
        viewControllers = tabBarList
        selectedIndex = 1
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
