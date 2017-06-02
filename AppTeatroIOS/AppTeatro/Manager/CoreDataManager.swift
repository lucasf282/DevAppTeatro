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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
    
    // MARK: - Core Data Search support
    
    class func fetchObj(entityObject:AnyClass, selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [Evento]{
        var aray = [Evento]()
        
        let fetchRequest:NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: String(describing: entityObject))
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = "nome"
            //            switch selectedScopeIdx! {
            //            case 0:
            //                filterKeyword = "nome"
            //            case 1:
            //                filterKeyword = "lugar"
            //            default:
            //                filterKeyword = "nome"
            //            }
            
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
            
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try CoreDataManager.getContext().fetch(fetchRequest)
            
            aray = fetchResult as! [Evento]
            
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
            try CoreDataManager.getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
    }
    
}
