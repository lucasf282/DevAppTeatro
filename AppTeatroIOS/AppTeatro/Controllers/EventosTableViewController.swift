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
    var filtro : NSPredicate? = nil
    
    let detalheEventoSegue = "MostrarDetalheEvento"
    fileprivate var eventoItemArray = [Evento]()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet var eventosTable: UITableView!
    @IBAction func favoritar(_ sender: Any) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if isUserLoggedIn {
            
        }else{
            // Display alert message with confirmation
            let myAlert = UIAlertController(title: "Alert", message: "Você precisa estar conectado a uma conta", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default){
                action in
                self.dismiss(animated: true, completion: nil)
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(filtro == nil){
            if self.revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        }
        
        // Sincronizar objetos da base
        updateData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func updateData() {
        if(filtro != nil){
            eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, predicate: filtro)
        } else{
        eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self)
        }
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
        if let agenda = evtItem.listaAgenda?.allObjects.first as? Agenda {
            cell.labelDataHora.text = agenda.dataHora
            if let ingresso = agenda.listaIngresso?.allObjects.first as? Ingresso {
                cell.labelPreco.text = "R$" + String(describing: ingresso.preco)
            }else{
                cell.labelPreco.text = evtItem.valor
            }
        }else{
            cell.labelDataHora.text = evtItem.diaHora
            cell.labelPreco.text = evtItem.valor
        }
        cell.labelLocal.text = evtItem.local?.nome ?? "Local não definido"
        
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
    // MARK: - Segments
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func IndexChenged(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0:
            eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, sortBy: "nome", isAscending: true, predicate: nil)
            eventosTable.reloadData()
        case 1:
            eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, sortBy: "nome", isAscending: false, predicate: nil)
            eventosTable.reloadData()
        case 2:
            let predicate = NSPredicate(format: "nome contains[c] %@", "impro")
            eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, sortBy: "nome", isAscending: true, predicate: predicate)
            eventosTable.reloadData()
        default:
            break
        }
    }
    
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

// MARK: - SearchBarDelegate
extension EventosTableViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self)
            tableView.reloadData()
            return
        }
        
        let predicate = NSPredicate(format: "nome contains[c] %@", searchText)
        eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, predicate: predicate)
//        eventoItemArray = CoreDataManager.fetchObj(entityName: Evento.self, sortBy: "nome", isAscending: true, predicate: predicate)
        
        tableView.reloadData()
        print(searchText)
    }
}
