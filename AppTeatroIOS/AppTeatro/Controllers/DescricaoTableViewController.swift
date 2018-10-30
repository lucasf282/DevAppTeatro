//
//  DescricaoTableViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/8/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class DescricaoTableViewController: UITableViewController {
    
    var evento : Event?
    let localSegue = "descricaoToLocalSegue"
    
    @IBOutlet weak var textView_desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dataHora: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var preco: UILabel!
    
    @IBOutlet weak var btn_favorito: UIButton!
    @IBAction func Favoritar(_ sender: UIButton) {
        btn_favorito.isSelected = !btn_favorito.isSelected
    }
    
    let textExemplo = "Lorem ipsum dolor sit er elit lamet, consectetaur kj fasds; Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore fjasdlkj fasdsdsfa."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.loadImageUsingCacheWithURLString(evento?.imagem ?? "",placeHolder: nil)
        dataHora.text = evento?.listaAgenda?.first?.data
        local.text = evento?.local?.nome
        preco.text = evento?.listaAgenda?.first?.listaIngresso?.first?.preco
        
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return evento?.nome
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
    
    // MARK: - Navigation
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case localSegue:
            return self.evento?.local != nil
        default:
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case localSegue:
                (segue.destination as! LocalViewController).local = self.evento?.local
            default:
                break;
            }
        }
    }
    
}
