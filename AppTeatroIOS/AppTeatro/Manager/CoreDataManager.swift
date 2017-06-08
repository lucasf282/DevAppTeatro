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
    
    // MARK: - Core Data Search support
    
    //    func retrieve<T: NSManagedObject>(entityClass:T.Type, sortBy:String? = nil, isAscending:Bool = true, predicate:NSPredicate? = nil) -> T[] {
    //        let entityName = NSStringFromClass(entityClass)
    //        let request    = NSFetchRequest(entityName: entityName)
    //
    //        request.returnsObjectsAsFaults = false
    //        request.predicate = predicate
    //
    //        if (sortBy != nil) {
    //            var sorter = NSSortDescriptor(key:sortBy , ascending:isAscending)
    //            request.sortDescriptors = [sorter]
    //        }
    //
    //        var error: NSError? = nil
    //        var fetchedResult = myDataModel.managedObjectContext.executeFetchRequest(request, error: &error)
    //        if !error {
    //            println("errore: \(error)")
    //        }
    //
    //        println("retrieved \(fetchedResult.count) elements for \(entityName)")
    //        return fetchedResult
    //    }
    
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
