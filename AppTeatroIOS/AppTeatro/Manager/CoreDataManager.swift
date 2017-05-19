//
//  CoreDataManager.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 18/05/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import CoreData

struct eventoItem {
    var eventoNome:String?
    var eventoGenero:String?
    var eventoDescricao:String?
    
    init() {
        eventoNome = ""
        eventoGenero = ""
        eventoDescricao = ""
    }
    
    init(nome:String,genero:String,descricao:String) {
        self.eventoNome = nome
        self.eventoGenero = genero
        self.eventoDescricao = descricao
    }
}

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(nome:String,genero:String,descricao:String) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Evento", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(nome, forKey: "nome")
        managedObj.setValue(genero, forKey: "genero")
        managedObj.setValue(descricao, forKey: "descricao")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///fetch all the objects from core data
    class func fetchObj(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [eventoItem]{
        var aray = [eventoItem]()
        
        let fetchRequest:NSFetchRequest<Evento> = Evento.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "nome"
            case 1:
                filterKeyword = "genero"
            default:
                filterKeyword = "descricao"
            }
            
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
            
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let evt = eventoItem(nome: item.nome!, genero: item.genero!, descricao: item.descricao!)
                aray.append(evt)
                print("Titulo:"+evt.eventoNome!+"\nGenero:"+evt.eventoGenero!+"\nDescricao:"+evt.eventoDescricao!+"\n")
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }
    
    ///delete all the data in core data
    class func cleanCoreData() {
        
        let fetchRequest:NSFetchRequest<Evento> = Evento.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
    }
    
}
