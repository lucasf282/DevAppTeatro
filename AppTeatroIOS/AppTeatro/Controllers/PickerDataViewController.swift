//
//  PickerDataViewController.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 09/08/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

@objc protocol DataSelectedDelegate{
    func dataSelectedDelegate(data: String)
}

class PickerDataViewController: UIViewController{
    var delegate: DataSelectedDelegate?
    var dataSelecionada: String?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if dataSelecionada != nil {
            dataPicker.date = dateFormatter.date(from: dataSelecionada!)!
        }
    }
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selecionar(_ sender: Any) {
        let dateString = dateFormatter.string(from: dataPicker.date)
        
        delegate?.dataSelectedDelegate(data: dateString)
        self.dismiss(animated: true, completion: nil)
    }
    
}
