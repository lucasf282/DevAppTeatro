//
//  TeatrosTableViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 10/06/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class TeatrosTableViewController: UITableViewController {

    var evento : eventoItem?
         fileprivate var eventoItemArray = [eventoItem]()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        // 3. Sincronizar objetos da base
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventoItemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeatroCell", for: indexPath) as! TeatroTableViewCell
        
        // Configure the cell...
        //cell.heightAnchor.constraint(equalTo: <#T##NSLayoutDimension#>, multiplier: <#T##CGFloat#>)
        
        let evtItem = eventoItemArray[indexPath.row]
        
        cell.imgViewTeatro.image = UIImage(named: evtItem.eventoNome!)
        cell.labelTituloTeatro.text = evtItem.eventoNome!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let largura = tableView.frame.size.width
        return largura/16*9
        
    }

    
    func updateData() {
        eventoItemArray = CoreDataManager.fetchObj()
    }

}
