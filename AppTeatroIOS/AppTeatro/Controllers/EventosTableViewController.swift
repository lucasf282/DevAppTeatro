//
//  EventosTableViewController.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 03/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth

class EventosTableViewController: UITableViewController{
    
    var evento : Event?
    var events : [Event]?
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
    
    @IBOutlet var eventosTable: UITableView!
    @IBAction func favoritar(_ sender: Any) {
        if Auth.auth().currentUser?.uid != nil {
            //TODO: metodo de favoritar
        }else{
            let myAlert = UIAlertController(title: "Alert", message: "Você precisa estar conectado a uma conta", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default){
                action in
                self.tabBarController?.selectedIndex = 2;
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.default){
                action in
                self.dismiss(animated: true, completion: nil)
            }
            myAlert.addAction(okAction)
            myAlert.addAction(cancelAction)
            self.present(myAlert, animated: true, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.performFetch()
        self.loadJsonWith(size: 12, page: 0)
    }
    func loadJsonWith(size:Int, page:Int){
        let jsonUrlString = "https://teatro-api.herokuapp.com/eventos?peagle&size=\(size)&page=\(page)"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            if err != nil {
                print("error on runTask:", err!)
                return
            }
            guard let data = data else { return }
            
            do{
                let decoder = JSONDecoder()
                let content = try decoder.decode(Content.self, from: data)
                self.events = content.content
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonErr {
                print("error on json:", jsonErr)
            }
        }.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performFetch() {
        do {
            if(filtro != nil){
                fetchedhResultController.fetchRequest.predicate = filtro
                try fetchedhResultController.performFetch()
                //tableView.reloadData()
            } else{
                try fetchedhResultController.performFetch()
            }
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = events?.count{
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventoCell", for: indexPath) as! EventoTableViewCell
        
        guard let evtItem = events?[indexPath.row] else { return cell}
        
        cell.ImgView_capa.loadImageUsingCacheWithURLString(evtItem.imagem ?? "",placeHolder: nil)
        cell.labelTitulo.text = evtItem.nome
        if let agenda = evtItem.listaAgenda?.first {
            cell.labelDataHora.text = agenda.data
            cell.labelHora.text = agenda.horario
            if let ingresso = agenda.listaIngresso?.first {
                cell.labelPreco.text = "R$" + (ingresso.preco ?? "--,--")
            }
        }
        cell.labelLocal.text = evtItem.local?.nome ?? "Local não definido"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let largura = tableView.frame.size.width
        return largura/16*9
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.evento = events?[indexPath.row]
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
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension EventosTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert{
            if newIndexPath != nil {
                //eventosTable.insertRows(at: [index], with: UITableViewRowAnimation.automatic)
            }
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        eventosTable.reloadData()
    }
    
}
