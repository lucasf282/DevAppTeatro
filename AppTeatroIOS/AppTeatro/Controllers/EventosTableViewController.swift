//
//  EventosTableViewController.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 03/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import CoreData

class EventosTableViewController: UITableViewController {
    
    var evento : Evento?
    let detalheEventoSegue = "MostrarDetalheEvento"
    fileprivate var eventoItemArray = [Evento]()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        //Inicialização do Core Data
        // 1. Deletar todos os objetos da base
        CoreDataManager.cleanCoreData()
        
        // 2. Inserir objetos na base
        presetCoreData()
        
        // 3. Sincronizar objetos da base
        updateData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func presetCoreData() {
        let eventoClassName: String = String(describing: Evento.self)
        let localClassName: String = String(describing: Local.self)
        
        let evento1: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        evento1.nome = "Improvaveis"
        evento1.diaHora = "21/02 - 19h"
        evento1.genero = "Comedia"
        evento1.valor = "R$ 30,00"
        evento1.descricao = "A Cia.Barbixas de Humor é formada por..."
        
        let evento2: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        evento2.nome = "Melhores do Mundo"
        evento2.diaHora = "10/05 - 20h"
        evento2.genero = "Comedia"
        evento2.valor = "R$ 40,00"
        evento2.descricao = "A Cia de comédia Os Melhores do Mundo..."

        let evento3: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        evento3.nome = "G7"
        evento3.diaHora = "06/06 - 18h"
        evento3.genero = "Comedia"
        evento3.valor = "R$ 25,00"
        evento3.descricao = "O G7 há 14 anos faz teatro..."
        
        let local1: Local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: CoreDataManager.getContext()) as! Local
        local1.nome = "Teatro UNIP"
        local1.estado = "DF"
        local1.cidade = "Santa Maria"
        local1.endereco = "QR 114 lote 12"
        local1.coplemento = "area especial"
        local1.addToListaEvento(evento1)
        
        let local2: Local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: CoreDataManager.getContext()) as! Local
        local2.nome = "Teatro Marista"
        local2.estado = "DF"
        local2.cidade = "Brasília"
        local2.endereco = "L2 sul QR 616 lote 24"
        local2.coplemento = "area especial"
        local2.addToListaEvento(evento2)
        local2.addToListaEvento(evento3)
        
        CoreDataManager.saveContext()
    }
    
    func updateData() {
        eventoItemArray = CoreDataManager.fetchObj(entityObject: Evento.self)
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
        
        let evtItem = eventoItemArray[indexPath.row]
        
        cell.ImgView_capa.image = UIImage(named: evtItem.nome ?? "CapaTeste")
        cell.labelTitulo.text = evtItem.nome
        cell.labelDataHora.text = evtItem.diaHora
        cell.labelLocal.text = evtItem.local?.nome ?? "Local não definido"
        cell.labelPreco.text = evtItem.valor
        
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
