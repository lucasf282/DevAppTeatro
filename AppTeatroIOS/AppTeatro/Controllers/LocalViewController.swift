//
//  LocalViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/12/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocalViewController: UIViewController{
    
    var local : Local?
    var conteudo : [[String]]?
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let teatro = local {
            conteudo = [
                ["Nome:", teatro.nome ?? "nome"],
                ["Endereço:", teatro.endereco ?? "endereço"],
                ["Complemento:", teatro.complemento ?? "complemento"],
                ["Cidade/Estado:", "\(teatro.cidade ?? "cidade") / \(teatro.estado ?? "estado")"],
                ["Telefone:", teatro.telefone ?? "telefone"]]
            
            self.marcarPonto(teatro: teatro)
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: UITableViewDelegate
extension LocalViewController: UITableViewDelegate{
    
}

//MARK: UITableViewDataSource
extension LocalViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalCell", for: indexPath) as! LocalTableViewCell
        
        if let info = conteudo {
            cell.UILabel_titulo.text = info[indexPath.row][0]
            cell.UILabel_valor.text = info[indexPath.row][1]
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

//MARK: MKMapViewDelegate
extension LocalViewController: MKMapViewDelegate{
    func marcarPonto(teatro: Local){
        let point = MKPointAnnotation();
        if (teatro.latitude != nil && teatro.longitude != nil) {
            point.coordinate = CLLocationCoordinate2DMake(Double(teatro.latitude!)!, Double(teatro.longitude!)!)
            //-15.8373354, -47.9160457 - teatro marista
            //-15.836053 , -47.912541  - iesb
            //-15.8186166, -47.9225928 - unip
            point.title = teatro.nome ?? "Teatro"
            mapView.addAnnotation(point)
            mapView.camera.altitude = pow(2, 11)
            mapView.showAnnotations([point], animated: false)
        }
    }
}

//MARK: CLLocationManagerDelegate
extension LocalViewController: CLLocationManagerDelegate{
    // trocar esse método por um botão para criar rota.
    //testar mostrar posição do usuário
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            mapView.showsUserLocation = true
            
            if let coordinate = locationManager.location?.coordinate{
                let point = MKPointAnnotation();
                point.coordinate = coordinate //-15.8348257,-47.9137472)iesb
                point.title = "usuário"
                //mapView.addAnnotation(point)
                mapView.camera.altitude = pow(2, 11)
                //mapView.showAnnotations([point], animated: false)
                mapView.setCenter(coordinate, animated: true)
            } else{
                locationManager.startUpdatingLocation()
            }
        } else {
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            mapView.setCenter(location.coordinate, animated: true)
            let point = MKPointAnnotation();
            point.coordinate = location.coordinate
            point.title = "usuario"
            mapView.addAnnotation(point)
            mapView.camera.altitude = pow(2, 11)
            mapView.showAnnotations([point], animated: false)
        }
    }
}
