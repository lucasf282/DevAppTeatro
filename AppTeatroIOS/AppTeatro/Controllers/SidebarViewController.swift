//
//  SidebarViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/5/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController, UITableViewDataSource{

    var menu = [["FavoriteFilledIcon", "Login"],
                ["FavoriteIcon", "Teste"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidebarCell", for: indexPath) as! SidebarMenuTableViewCell
        
        cell.ImgView_icone.image = UIImage(named: menu[indexPath.row][0])
        cell.label_opcao.text = menu[indexPath.row][1]
        
        return cell
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
