//
//  FiltroViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/20/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController, HoraSelectedDelegate {
    
    var horaMin: String?
    var horaMax: String?
    var isHoraMin = true // variavel para seber quem chamou o picker de hora
    
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

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "horaPickerMin" {
            let controller = segue.destination as! PickerHoraViewController
            controller.delegate = self
            controller.horaSelecionada = horaMin
            isHoraMin = true
        }
        if segue.identifier == "horaPickerMax" {
            let controller = segue.destination as! PickerHoraViewController
            controller.delegate = self
            controller.horaSelecionada = horaMax
            isHoraMin = false
        }
    }

}
