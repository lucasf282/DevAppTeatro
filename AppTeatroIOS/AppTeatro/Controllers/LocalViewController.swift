//
//  LocalViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/12/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var local : Local?
    var conteudo : [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let teatro = local {
            conteudo = [
                ["Nome:", teatro.nome ?? "nome"],
                ["Endereço:", teatro.endereco ?? "endereço"],
                ["Complemento:", teatro.complemento ?? "complemento"],
                ["Cidade/Estado:", "\(teatro.cidade ?? "cidade") / \(teatro.estado ?? "estado")"],
                ["Telefone:", teatro.telefone ?? "telefone"]
            ]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalCell", for: indexPath) as! LocalTableViewCell
        
        if let info = conteudo {
            cell.UILabel_titulo.text = info[indexPath.row][0]
            cell.UILabel_valor.text = info[indexPath.row][1]
        }
        return cell
    }
}
