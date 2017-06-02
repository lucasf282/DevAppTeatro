//
//  DescricaoTableViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/8/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class DescricaoTableViewController: UITableViewController {
    
    var evento : Evento?
    
    @IBOutlet weak var textView_desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dataHora: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var preco: UILabel!
    
    let textExemplo = "Lorem ipsum dolor sit er elit lamet, consectetaur kj fasds; Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore fjasdlkj fasdsdsfa."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage(named: evento?.nome ?? "CapaTeste")
        dataHora.text = evento?.diaHora
        local.text = evento?.local?.nome
        preco.text = evento?.valor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let largura = tableView.frame.size.width
            return largura/16*9
        }
        if indexPath.row == 4 {
            // 9  de espaçamento interno da textview
            let largura = tableView.frame.size.width - 141 + 9
            //print(" tableview \(largura)")
            
            let altura = textExemplo.height(withConstrainedWidth: largura, font: UIFont.systemFont(ofSize: 14))+16+24
            // 16 de espaçamento da celula
            // 24 de espaçamento interno da textView
            //print(" altura \(altura)")
            return altura
        }
        return 64
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     if indexPath.row == 4 {
     }
     // Configure the cell...
     
     return cell
     }
     */
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
