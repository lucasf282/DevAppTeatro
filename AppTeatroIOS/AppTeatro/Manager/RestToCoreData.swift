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
            if let id = dictionary["id"] as? Int64{
                ingresso.id = id
            }
            if let quant = dictionary["quantidade"] as? Int16{
                ingresso.quantidade = quant
            }
            ingresso.nome = dictionary["nome"] as? String
            
            if let preco = (dictionary["preco"] as? String){
                ingresso.preco = Double(preco.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".")) ?? 0.0
            }
            
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
            if let data = dictionary["data"] as? NSArray{
                if let dia = data[2] as? Int{
                    if let mes = data[1] as? Int{
                        if let ano = data[0] as? Int{
                            agenda.dataHora = "\(dia)/\(mes)/\(ano)"
                        }
                    }
                }
                
                if let hora = dictionary["horario"] as? String{
                    agenda.dataHora = agenda.dataHora ?? "" + " - " + hora
                }
            }
            
            if let ingressos = dictionary["listaIngresso"] as? NSMutableArray{
                if let ingressoDictionary =  ingressos[0] as? [String: AnyObject]{
                    if let ingresso = self.createIngressoEntityFrom(dictionary: ingressoDictionary) as? Ingresso{
                        agenda.addToListaIngresso(ingresso)
                    }
                }
            }
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
            if let agendas = dictionary["listaAgenda"] as? NSMutableArray{
                if let agendaDictionary =  agendas[0] as? [String: AnyObject]{
                    if let agenda = self.createAgendaEntityFrom(dictionary: agendaDictionary) as? Agenda{
                        evento.addToListaAgenda(agenda)
                        evento.diaHora = agenda.dataHora
                    }
                }
            }
            evento.genero = dictionary["genero"] as? String
            evento.valor = "R$ 30,00"
            evento.descricao = dictionary["descricao"] as? String
            
            let url = dictionary["imagem"] as? String
            let urlImage = URL(string: url!)
            let data = try? Data(contentsOf: urlImage!)
            evento.foto = data as NSData?
            
            if let localDictionary = dictionary["local"] as? [String: AnyObject]{
                evento.local = self.createLocalEntityFrom(dictionary: localDictionary) as? Local
            }
            
            print(evento)
            return evento
        }
        return nil
    }
    
    private func createLocalEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataManager.getContext()
        
        if let local = CoreDataManager.fetchObjById(entityName: Local.self, id: dictionary["id"] as? Int64) {
            return local
        }else {
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
        }
        return nil
    }
    
}
