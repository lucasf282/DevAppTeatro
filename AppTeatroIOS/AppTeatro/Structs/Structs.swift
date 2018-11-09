//
//  Structs.swift
//  AppTeatro
//
//  Created by Lucas Farias on 28/10/18.
//  Copyright © 2018 MyMac. All rights reserved.
//
struct Content: Decodable{
    let content:[Event]?
    let last:Bool?
    let totalPages:Int?
    let totalElements:Int?
    let sort:String?
    let first:Bool?
    let numberOfElements:Int?
    let size:Int?
    let number:Int?
}

struct Event: Decodable{
    let id:Int?
    let nome:String?
    let descricao:String?
    let imagem:String?
    let genero:String?
    let informacao:Information?
    let listaAgenda:[schedule]?
    let local:Theater?
    let favoritado:String?
}
struct Theater: Decodable{
    let id:Int?
    let nome:String?
    let endereco:String?
    let complemento:String?
    let cidade:String?
    let estado:String?
    let telefone:String?
    let latitude:String?
    let longitude:String?
    let imagem:String?
}
struct Information: Decodable{
    let elenco:String?
    let ficha:String?
    let duracao:String?
}

struct schedule: Decodable{
    let id:Int?
    let data:String?
    let horario:String?
    let listaIngresso:[Ticket]?
}

struct Ticket: Decodable{
    let id:Int?
    let nome:String?
    let preco:String?
    let quantidade:Int?
}

struct ChatMessage: Decodable{
    let messageText:String?
    let messageTime:CLong?
    let messageUser:String?
}
