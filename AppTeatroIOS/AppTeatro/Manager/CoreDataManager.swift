//
//  CoreDataManager.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 18/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    private init(){
        
    }
    
    class func getContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "AppTeatro")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func presetCoreData() {
        let usuarioClassName: String = String(describing: Usuario.self)
        
        
        let usuario: Usuario = NSEntityDescription.insertNewObject(forEntityName: usuarioClassName, into: CoreDataManager.getContext()) as! Usuario
        usuario.email = "exemplo@email.com"
        usuario.senha = "123"

        RestToCoreData().presetCoreData()
        
        // TO-DO Refatorar
        //        let url = URL(string: "https://teatro-api.herokuapp.com/eventos")
        //        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        //            if error != nil{
        //                print ("ERROR");
        //            }
        //            else{
        //                if let content = data{
        //                    do {
        //                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        //
        //                        var eventos: [Evento] = []
        //
        //                        for json in myJson as! [[String:Any]]{
        //                            let evento1: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        //                            evento1.nome = json["nome"] as? String
        //                            evento1.diaHora = "21/02 - 19h"
        //                            evento1.genero = "Comedia"
        //                            evento1.valor = "R$ 30,00"
        //                            evento1.descricao = json["descricao"] as? String
        //
        //                            if let rates = json["local"] as? NSDictionary{
        //                                print(rates)
        //
        //                                let local1: Local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: CoreDataManager.getContext()) as! Local
        //                                local1.nome = rates["nome"] as? String
        //                                local1.estado = rates["estado"] as? String
        //                                local1.cidade = rates["cidade"] as? String
        //                                local1.endereco = rates["endereco"] as? String
        //                                local1.complemento = rates["complemento"] as? String
        //                                local1.telefone = rates["telefone"] as? String
        //                                local1.latitude = "-15.8175238"
        //                                local1.longitude = "-47.9223492"
        //                                evento1.local = local1
        //                            }
        //
        //                            eventos.append(evento1)
        //
        //                        }
        //
        //                    }
        //                    catch{
        //
        //                    }
        //                }
        //            }
        //        }
        //        task.resume()
        
        // TO-DO Refatorar
        
        //        let evento1: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        //        evento1.nome = "Improvaveis"
        //        evento1.diaHora = "21/02 - 19h"
        //        evento1.genero = "Comedia"
        //        evento1.valor = "R$ 30,00"
        //        evento1.descricao = "A Cia.Barbixas de Humor é formada por..."
        //
        //        let evento2: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        //        evento2.nome = "Melhores do Mundo"
        //        evento2.diaHora = "10/05 - 20h"
        //        evento2.genero = "Comedia"
        //        evento2.valor = "R$ 40,00"
        //        evento2.descricao = "A Cia de comédia Os Melhores do Mundo..."
        //
        //        let evento3: Evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: CoreDataManager.getContext()) as! Evento
        //        evento3.nome = "G7"
        //        evento3.diaHora = "06/06 - 18h"
        //        evento3.genero = "Comedia"
        //        evento3.valor = "R$ 25,00"
        //        evento3.descricao = "O G7 há 14 anos faz teatro..."
        //
        //        let local1: Local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: CoreDataManager.getContext()) as! Local
        //        local1.nome = "Teatro UNIP"
        //        local1.estado = "DF"
        //        local1.cidade = "Santa Maria"
        //        local1.endereco = "QR 114 lote 12"
        //        local1.complemento = "area especial"
        //        local1.telefone = "(61) 00000 0000"
        //        local1.addToListaEvento(evento1)
        //
        //        let local2: Local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: CoreDataManager.getContext()) as! Local
        //        local2.nome = "Teatro Marista"
        //        local2.estado = "DF"
        //        local2.cidade = "Brasília"
        //        local2.endereco = "L2 sul QR 616 lote 24"
        //        local2.complemento = "area especial"
        //        local2.telefone = "(61) 00000 0000"
        //        local2.latitude = "-15.8373354"
        //        local2.longitude = "-47.9160457"
        //        local2.addToListaEvento(evento2)
        //        local2.addToListaEvento(evento3)
        
        
        CoreDataManager.saveContext()
    }
    
    
    // MARK: - Core Data Search support
    
    class func fetchObj<T: NSManagedObject>(entityName:T.Type, sortBy:String? = nil, isAscending:Bool = true, predicate:NSPredicate? = nil) -> [T]{
        var aray = [NSManagedObject]()
        
        let fetchRequest:NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        if (sortBy != nil) {
            let sorter = NSSortDescriptor(key:sortBy , ascending:isAscending)
            fetchRequest.sortDescriptors = [sorter]
        }
        
        do {
            let fetchResult = try CoreDataManager.getContext().fetch(fetchRequest)
            
            aray = fetchResult
            
        }catch {
            print(error.localizedDescription)
        }
        
        return aray as! [T]
    }
    
    
    ///delete all the data in core data
    class func cleanCoreData() {
        
        let fetchRequestEvento:NSFetchRequest<Evento> = Evento.fetchRequest()
        let fetchRequestLocal:NSFetchRequest<Local> = Local.fetchRequest()
        
        let deleteRequestEvento = NSBatchDeleteRequest(fetchRequest: fetchRequestEvento as! NSFetchRequest<NSFetchRequestResult>)
        let deleteRequestLocal = NSBatchDeleteRequest(fetchRequest: fetchRequestLocal as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try CoreDataManager.getContext().execute(deleteRequestEvento)
            try CoreDataManager.getContext().execute(deleteRequestLocal)
        }catch {
            print(error.localizedDescription)
        }
    }
}
