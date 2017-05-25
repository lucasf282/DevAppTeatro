//
//  FiltroViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/20/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController, HoraSelectedDelegate, GeneroSelectedDelegate{
    
    var horaMin: String?
    var horaMax: String?
    var isHoraMin = true // variavel para seber qual botão chamou o picker de hora
    var generosSelecionados: [String]?
    
    @IBOutlet weak var btn_genero: UIButton!
    @IBOutlet weak var TextFild_local: UITextField!
    @IBOutlet weak var SegmentedControl_local: UISegmentedControl!
    @IBOutlet weak var btn_horaMin: UIButton!
    @IBOutlet weak var btn_horaMax: UIButton!
    
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
        if generosSelecionados.count == 1 {
            btn_genero.setTitle(generosSelecionados[0], for: UIControlState.normal)
            btn_genero.setTitle(generosSelecionados[0], for: UIControlState.selected)
        }else{
            btn_genero.setTitle("Vários", for: UIControlState.normal)
            btn_genero.setTitle("Vários", for: UIControlState.selected)
        }
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
    }

}
