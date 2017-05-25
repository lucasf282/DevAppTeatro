//
//  LocalViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/12/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let conteudo = [["Nome:", "Teatro Nacional"],
                    ["Endereço:", "apenas endereço de teste."],
                    ["Complemento:", "não sei o que por aqui"],
                    ["Cidade/Estado:", "Brasília - DF"],
                    ["Telefone:", "(61) 00000-0000"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        cell.UILabel_titulo.text = conteudo[indexPath.row][0]
        cell.UILabel_valor.text = conteudo[indexPath.row][1]
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
