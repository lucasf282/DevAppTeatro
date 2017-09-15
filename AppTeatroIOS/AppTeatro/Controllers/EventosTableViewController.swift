//
//  EventosTableViewController.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 03/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import CoreData

class EventosTableViewController: UITableViewController{
    
    var evento : Evento?
    var filtro : NSPredicate? = nil
    
    let detalheEventoSegue = "MostrarDetalheEvento"
    
    lazy var fetchedhResultController: NSFetchedResultsController<Evento> = {
        let fetchRequest = NSFetchRequest<Evento>(entityName: String(describing: Evento.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let context = CoreDataManager.getContext()
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet var eventosTable: UITableView!
    @IBAction func favoritar(_ sender: Any) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if isUserLoggedIn {
            
        }else{
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
        
        self.performFetch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performFetch() {
        do {
            try fetchedhResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?[section].numberOfObjects{
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventoCell", for: indexPath) as! EventoTableViewCell
        
        let evtItem = fetchedhResultController.object(at: indexPath)
        
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
        self.evento = fetchedhResultController.object(at: indexPath)
        self.performSegue(withIdentifier: detalheEventoSegue, sender: nil)
    }
    
    // MARK: - Segments
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func IndexChenged(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0:
            fetchedhResultController.fetchRequest.predicate = nil
            fetchedhResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
            performFetch()
            tableView.reloadData()
        case 1:
            fetchedhResultController.fetchRequest.predicate = nil
            fetchedhResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: false)]
            performFetch()
            tableView.reloadData()
        case 2:
            let predicate = NSPredicate(format: "nome contains[c] %@", "cl")
            fetchedhResultController.fetchRequest.predicate = predicate
            performFetch()
            tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier{
            switch identifier {
            case detalheEventoSegue:
                (segue.destination as! DescricaoTableViewController).evento = self.evento!
                self.evento = nil
                
            default:
                break;
                
            }
        }
    }
}

// MARK: - SearchBarDelegate
extension EventosTableViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            fetchedhResultController.fetchRequest.predicate = nil
            fetchedhResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            performFetch()
            tableView.reloadData()
            return
        }
        
        let predicate = NSPredicate(format: "nome contains[c] %@", searchText)
        fetchedhResultController.fetchRequest.predicate = predicate
        fetchedhResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        performFetch()
        tableView.reloadData()
        print(searchText)
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension EventosTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert{
            if let index = newIndexPath {
                //eventosTable.insertRows(at: [index], with: UITableViewRowAnimation.automatic)
            }
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        eventosTable.reloadData()
    }
    
}
