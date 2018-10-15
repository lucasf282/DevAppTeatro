//
//  OnBoard03ViewController.swift
//  AppTeatro
//
//  Created by Lucas Farias on 24/09/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit

class OnBoard03ViewController: UIViewController {

    @IBAction func finishOnboardAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "skipTutorialPages")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
