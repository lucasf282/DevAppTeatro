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
    var eventoDiaeHora:String?
    var eventoLocal:String?
    var eventoValor:String?
    var eventoDescricao:String?
    
    init() {
        eventoNome = ""
        eventoDiaeHora = ""
        eventoLocal = ""
        eventoValor = ""
        eventoDescricao = ""
    }
    
    init(nome:String,diaHora:String,local:String,valor:String,descricao:String) {
        self.eventoNome = nome
        self.eventoDiaeHora = diaHora
        self.eventoLocal = local
        self.eventoValor = valor
        self.eventoDescricao = descricao
    }
    
}

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(nome:String,diaHora:String,local:String,valor:String,descricao:String) {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Evento", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(nome, forKey: "nome")
        managedObj.setValue(diaHora, forKey: "diaHora")
        managedObj.setValue(local, forKey: "lugar")
        managedObj.setValue(valor, forKey: "valor")
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
                filterKeyword = "lugar"
            default:
                filterKeyword = "nome"
            }
            
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
            
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let evt = eventoItem(nome: item.nome!, diaHora: item.diaHora!, local: item.lugar!, valor: item.valor!, descricao: item.descricao!)
                aray.append(evt)
                print("Titulo:"+evt.eventoNome!+"\nDia e Hora:"+evt.eventoDiaeHora!+"\nLocal:"+evt.eventoLocal!+"\nValor:"+evt.eventoValor!+"\nDescrição:"+evt.eventoDescricao!+"\n")
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
