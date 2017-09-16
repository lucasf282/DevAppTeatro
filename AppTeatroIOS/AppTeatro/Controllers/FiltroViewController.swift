//
//  FiltroViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/20/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController, HoraSelectedDelegate, GeneroSelectedDelegate, DataSelectedDelegate{
    
    var horaMin: String? = ""
    var horaMax: String? = ""
    var isHoraMin = true // variavel para saber qual botão chamou o picker de hora
    var generosSelecionados: [String] = []
    var dataSelecionada: String? = ""
    
    @IBOutlet weak var btn_genero: UIButton!
    @IBOutlet weak var TextFild_local: UITextField!
    @IBOutlet weak var textField_evento: UITextField!
    @IBOutlet weak var SegmentedControl_local: UISegmentedControl!
    @IBOutlet weak var btn_horaMin: UIButton!
    @IBOutlet weak var btn_horaMax: UIButton!
    @IBOutlet weak var btn_data: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func horaSelectedDelegate(hora: String) {
        if isHoraMin{
            horaMin = hora
            btn_horaMin.setTitle(hora, for: UIControlState.normal)
            btn_horaMin.setTitle(hora, for: UIControlState.selected)
        }else{
            horaMax = hora
            btn_horaMax.setTitle(hora, for: UIControlState.normal)
            btn_horaMax.setTitle(hora, for: UIControlState.selected)
        }
    }
    
    func generoSelectedDelegate(generosSelecionados: [String]) {
        self.generosSelecionados = generosSelecionados
        if generosSelecionados.count == 1 {
            btn_genero.setTitle(generosSelecionados[0], for: UIControlState.normal)
            btn_genero.setTitle(generosSelecionados[0], for: UIControlState.selected)
        }else{
            btn_genero.setTitle("Vários", for: UIControlState.normal)
            btn_genero.setTitle("Vários", for: UIControlState.selected)
        }
    }
    
    func dataSelectedDelegate(data: String) {
        dataSelecionada = data
        btn_data.setTitle(dataSelecionada, for: UIControlState.normal)
        btn_data.setTitle(dataSelecionada, for: UIControlState.selected)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "horaPickerMinSegue" {
            let controller = segue.destination as! PickerHoraViewController
            controller.delegate = self
            controller.horaSelecionada = horaMin
            isHoraMin = true
        }
        if segue.identifier == "horaPickerMaxSegue" {
            let controller = segue.destination as! PickerHoraViewController
            controller.delegate = self
            controller.horaSelecionada = horaMax
            isHoraMin = false
        }
        if segue.identifier == "generosSegue" {
            let controller = segue.destination as! GenerosViewController
            controller.delegate = self
            controller.generosSelecionados = generosSelecionados
        }
        if segue.identifier == "dataPickerSegue" {
            let controller = segue.destination as! PickerDataViewController
            controller.delegate = self
            controller.dataSelecionada = dataSelecionada
        }
        if segue.identifier == "filtroEvento"{
            // TO-DO Colocar o restante dos filtros
            let predicateGenero = NSPredicate(format: "genero IN %@", generosSelecionados)
            let predicateNomeEvento = NSPredicate(format: "nome contains[c] %@", textField_evento.text!)
            let predicateNomeLocal = NSPredicate(format: "local.nome contains[c] %@", TextFild_local.text!)
            let predicateHora = NSPredicate(format: "(ANY listaAgenda.hora >= %@) AND (ANY listaAgenda.hora <= %@)", horaMin!, horaMax!)
             let predicateData = NSPredicate(format: "ANY listaAgenda.dataHora == %@", dataSelecionada!)
            
            let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicateNomeEvento, predicateNomeLocal, predicateGenero, predicateHora, predicateData])
            
            (segue.destination as! EventosTableViewController).filtro = predicateCompound
        }
        
    }
    
}
