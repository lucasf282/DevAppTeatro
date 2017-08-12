//
//  LocalViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/12/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import MapKit

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{
    
    var local : Local?
    var conteudo : [[String]]?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let point = MKPointAnnotation();
        if let teatro = local {
            conteudo = [
                ["Nome:", teatro.nome ?? "nome"],
                ["Endereço:", teatro.endereco ?? "endereço"],
                ["Complemento:", teatro.complemento ?? "complemento"],
                ["Cidade/Estado:", "\(teatro.cidade ?? "cidade") / \(teatro.estado ?? "estado")"],
                ["Telefone:", teatro.telefone ?? "telefone"]
                
            ]
            
            if (teatro.latitude != nil && teatro.longitude != nil) {
                point.coordinate = CLLocationCoordinate2DMake(Double(teatro.latitude!)!, Double(teatro.longitude!)!)//-15.8373354, -47.9160457)
                point.title = teatro.nome ?? "nome"
                
                mapView.addAnnotation(point)
                mapView.camera.altitude = pow(2, 11)
                mapView.showAnnotations([point], animated: false)
            }
            
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
