//
//  EventosTableViewController.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 03/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class EventosTableViewController: UITableViewController {
    
    var evento : eventoItem?
    let detalheEventoSegue = "MostrarDetalheEvento"
    fileprivate var eventoItemArray = [eventoItem]()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if self.revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        //Inicialização do Core Data
        // 1. Deletar todos os objetos da base
        //CoreDataManager.cleanCoreData()
        
        // 2. Inserir objetos na base
        //presetCoreData()
        
        // 3. Sincronizar objetos da base
        updateData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func presetCoreData() {
        
        CoreDataManager.storeObj(nome: "Improvaveis", diaHora: "21/02 - 19h", local: "Teatro UNIP", valor: "R$ 30,00", descricao: "A Cia.Barbixas de Humor é formada por...")
        
        CoreDataManager.storeObj(nome: "Melhores do Mundo", diaHora: "10/05 - 20h", local: "Teatro dos Bancários", valor: "R$ 40,00", descricao: "A Cia de comédia Os Melhores do Mundo...")
        
        CoreDataManager.storeObj(nome: "G7", diaHora: "06/06 - 18h", local: "Teatro Marista", valor: "R$ 25,00", descricao: "O G7 há 14 anos faz teatro...")
    }
    
    func updateData() {
        eventoItemArray = CoreDataManager.fetchObj()
    }
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventoItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventoCell", for: indexPath) as! EventoTableViewCell
        
        // Configure the cell...
        //cell.heightAnchor.constraint(equalTo: <#T##NSLayoutDimension#>, multiplier: <#T##CGFloat#>)
        
        let evtItem = eventoItemArray[indexPath.row]
        
        cell.ImgView_capa.image = UIImage(named: evtItem.eventoNome!)
        cell.labelTitulo.text = evtItem.eventoNome!
        cell.labelDataHora.text = evtItem.eventoDiaeHora!
        cell.labelLocal.text = evtItem.eventoLocal!
        cell.labelPreco.text = evtItem.eventoValor!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let largura = tableView.frame.size.width
        return largura/16*9
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.evento = eventoItemArray[indexPath.row]
        self.performSegue(withIdentifier: detalheEventoSegue, sender: nil)
    }
    
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
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch identifier {
        case detalheEventoSegue:
            return self.evento != nil
        default:
            return true
            
        }
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier{
            switch identifier {
            case detalheEventoSegue:
                (segue.destination as! DescricaoTableViewController).evento = self.evento!
                self.evento = nil
                
            default:
                break;
                
            }
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
    }
    
}
