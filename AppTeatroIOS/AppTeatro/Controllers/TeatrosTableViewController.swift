//
//  TeatrosTableViewController.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 10/06/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class TeatrosTableViewController: UITableViewController {

    var local : Theater?
    var theaters : [Theater]?
    let localSegue = "teatrosToLocalSegue"
    fileprivate var  localArray = [Local]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonWith(size: 6, page: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadJsonWith(size:Int, page:Int){
        let jsonUrlString = "https://teatro-api.herokuapp.com/locais?peagle&size=\(size)&page=\(page)"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            if err != nil {
                print("error on runTask:", err!)
                return
            }
            guard let data = data else { return }
            
            do{
                let decoder = JSONDecoder()
                self.theaters = try decoder.decode([Theater].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonErr {
                print("error on json:", jsonErr)
            }
        }.resume()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = theaters?.count{
            return count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeatroCell", for: indexPath) as! TeatroTableViewCell
        
        guard let localItem = theaters?[indexPath.row] else { return cell}
        
        cell.imgViewTeatro.loadImageUsingCacheWithURLString(localItem.imagem ?? "",placeHolder: nil)
        cell.labelTituloTeatro.text = localItem.nome
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let largura = tableView.frame.size.width
        return largura/16*9
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.local = theaters?[indexPath.row]
        self.performSegue(withIdentifier: localSegue, sender: nil)
    }
    
    func updateData() {
        localArray = CoreDataManager.fetchObj(entityName: Local.self)
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case localSegue:
            return self.local != nil
        default:
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case localSegue:
                (segue.destination as! LocalViewController).local = self.local
                self.local = nil
            default:
                break;
            }
        }
    }

}
