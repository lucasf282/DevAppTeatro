//
//  TeatrosTableViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 10/06/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class TeatrosTableViewController: UITableViewController {

    var  local : Local?
    let localSegue = "teatrosToLocalSegue"
    fileprivate var  localArray = [Local]()
    
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
        print(localArray.count)
        return  localArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeatroCell", for: indexPath) as! TeatroTableViewCell
        
        let localItem =  localArray[indexPath.row]
        
        cell.imgViewTeatro.image = UIImage(named: localItem.nome!)
        cell.labelTituloTeatro.text = localItem.nome
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let largura = tableView.frame.size.width
        return largura/16*9
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        local = localArray[indexPath.row]
    }
    
    func updateData() {
         localArray = CoreDataManager.fetchObj(entityName: Local.self)
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case localSegue:
            return self.local != nil
        default:
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case localSegue:
                (segue.destination as! LocalViewController).local = self.local
            default:
                break;
            }
        }
    }

}
