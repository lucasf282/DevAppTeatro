//
//  ContentPageViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 07/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class ContentPageViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    var imageFileName: String!
    var pageIndex:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        myImageView.image = UIImage(named:imageFileName)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
