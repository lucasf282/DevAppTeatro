//
//  GenerosViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/15/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

@objc protocol GeneroSelectedDelegate{
    func generoSelectedDelegate(generosSelecionados: [String])
}

class GenerosViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    var delegate : GeneroSelectedDelegate?
    var generosSelecionados:[String]?
    
    let generos = [["generos_comedia", "comédia"], ["generos_drama", "drama"], ["generos_suspense", "suspense"], ["generos_outro1", "outro1"], ["generos_outro2", "outro2"], ["generos_outro3", "outro3"], ["generos_outro4", "outro4"]]
    
    
    @IBOutlet weak var collectionView_generos: UICollectionView!
    
    @IBAction func btnOK(_ sender: Any) {
        generosSelected()
        delegate?.generoSelectedDelegate(generosSelecionados: generosSelecionados ?? ["selecionar"])
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneroCell", for: indexPath) as! GeneroCollectionViewCell
        cell.btn_genero.setImage(UIImage(named: generos[indexPath.row][0]), for: UIControlState.normal)
        //cell.btn_genero.value(forKey: generos[indexPath.row][1])
        cell.label_genero.text = generos[indexPath.row][1]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let largura = (collectionView.frame.size.width-12*2)/3
        
        return CGSize(width: largura, height: largura+25)
    }
    
    func generosSelected(){
        let cells = collectionView_generos.visibleCells
        if generosSelecionados == nil{
            generosSelecionados = []
        }else{
            generosSelecionados?.removeAll()
        }
        for cell in cells {
            let generoCell = cell as! GeneroCollectionViewCell
            if generoCell.btnIsSelected {
                generosSelecionados?.append(generoCell.label_genero.text!) 
            }
        }
        print(generosSelecionados ?? "vazio")
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
