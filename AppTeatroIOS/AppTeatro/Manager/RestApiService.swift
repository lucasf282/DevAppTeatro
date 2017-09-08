//
//  RestApiService.swift
//  AppTeatro
//
//  Created by MyMac on 9/6/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class RestApiService: NSObject {
    lazy var urlString: String = { return "https://teatro-api.herokuapp.com/" }()
    
    func getDataWith(endPoint: String ,completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        let urlString = self.urlString + endPoint
        
        guard let url = URL(string: urlString) else { return completion(.Error("URL Invalida")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "Não há itens a serem mostrados"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: AnyObject]]{
                    DispatchQueue.main.async {
                        completion(.Success(json))
                    }
                }else{
                    print("Não há itens a serem mostrados")
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
}

enum Result<T> {
    case Success(T)
    case Error(String)
}

