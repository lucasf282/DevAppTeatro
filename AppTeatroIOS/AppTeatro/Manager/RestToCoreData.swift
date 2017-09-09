//
//  RestToCoreData.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 06/09/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import CoreData

class RestToCoreData{
    
    private let eventoClassName: String = String(describing: Evento.self)
    private let localClassName: String = String(describing: Local.self)
    private let usuarioClassName: String = String(describing: Usuario.self)
    private let agendaClassName: String = String(describing: Agenda.self)
    private let ingressoClassName: String = String(describing: Ingresso.self)
    
    func presetCoreDataEventos() {
        let restAPI = RestApiService()
        restAPI.getDataWith(endPoint: "eventos"){(result) in
            switch result {
            case .Success(let data):
                _ = data.map{self.createEventoEntityFrom(dictionary: $0)}
                CoreDataManager.saveContext()
            case .Error(let message):
                DispatchQueue.main.async {
                    print(message)
                }
            }
        }
    }
    
    func presetCoreDataLocais() {
        let restAPI = RestApiService()
        restAPI.getDataWith(endPoint: "locais"){(result) in
            switch result {
            case .Success(let data):
                _ = data.map{self.createLocalEntityFrom(dictionary: $0)}
                CoreDataManager.saveContext()
            case .Error(let message):
                DispatchQueue.main.async {
                    print(message)
                }
            }
        }
    }
    
    private func createIngressoEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataManager.getContext()
        
        if let ingresso = NSEntityDescription.insertNewObject(forEntityName: ingressoClassName, into: context) as? Ingresso {
            ingresso.setValuesForKeys(dictionary)
            return ingresso
        }
        return nil
    }
    
    private func createAgendaEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataManager.getContext()
        
        if let agenda = NSEntityDescription.insertNewObject(forEntityName: agendaClassName, into: context) as? Agenda {
            if let id = dictionary["id"] as? Int64{
                agenda.id = id
            }
            //let data = dictionary["data"] as? String
            let hora = dictionary["hora"] as? String
            agenda.dataHora = hora
            let ingressos = dictionary["listaIngresso"] as? NSArray
            
            //agenda.listaIngresso?.adding(createIngressoEntityFrom(dictionary: ingressos["0"]))
            return agenda
        }
        return nil
    }
    
    private func createEventoEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataManager.getContext()
        
        if let evento = NSEntityDescription.insertNewObject(forEntityName: eventoClassName, into: context) as? Evento {
            if let id = dictionary["id"] as? Int64{
                evento.id = id
            }
            evento.nome = dictionary["nome"] as? String
            let agendas = dictionary["listaAgenda"] as? NSDictionary
            print("conteudo lista agenda")
            print(agendas)
            //evento.listaAgenda?.adding(self.createAgendaEntityFrom(dictionary: agendas["0"]))
            evento.genero = dictionary["genero"] as? String
            evento.valor = "R$ 30,00"
            evento.descricao = dictionary["descricao"] as? String
            
            /* TO-DO
            if let local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: context) as? Local {
                if let localDictionary = dictionary["local"] as? [String: AnyObject]{
                    local.setValuesForKeys(localDictionary)
                }
                evento.local = local
            }*/
            
            return evento
        }
        return nil
    }
    
    private func createLocalEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataManager.getContext()
        
        if let local = NSEntityDescription.insertNewObject(forEntityName: localClassName, into: context) as? Local {
            if let id = dictionary["id"] as? Int64{
                local.id = id
            }
            local.nome = dictionary["nome"] as? String
            local.endereco = dictionary["endereco"] as? String
            local.complemento = dictionary["complemento"] as? String
            local.cidade = dictionary["cidade"] as? String
            local.estado = dictionary["estado"] as? String
            local.telefone = dictionary["telefone"] as? String
            local.latitude = dictionary["latitude"] as? String
            local.longitude = dictionary["longitude"] as? String
            
            return local
        }
        return nil
    }
    
}
