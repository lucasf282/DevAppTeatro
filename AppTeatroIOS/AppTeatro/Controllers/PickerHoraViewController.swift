//
//  PickerHoraViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/23/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

@objc protocol HoraSelectedDelegate{
    func horaSelectedDelegate(hora: String)
}

class PickerHoraViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var delegate : HoraSelectedDelegate?
    var horaSelecionada: String?
    var isMin = false
    
    var horarios = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]

    @IBOutlet weak var pickerView_hora: UIPickerView!
    
    @IBAction func cancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selecionar(_ sender: UIButton) {
        delegate?.horaSelectedDelegate(hora: horaSelecionada ?? "selecionar")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let index = horarios.index(of: horaSelecionada ?? "") ?? 0
        pickerView_hora.selectRow(index, inComponent: 0, animated: true)
        pickerView(pickerView_hora, didSelectRow: index, inComponent: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return horarios.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return horarios[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        horaSelecionada = horarios[row]
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
