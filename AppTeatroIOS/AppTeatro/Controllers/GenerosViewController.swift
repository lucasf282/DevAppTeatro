//
//  GenerosViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/15/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class GenerosViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    let generos = [["generos_comedia", "comédia"], ["generos_drama", "drama"], ["generos_suspense", "suspense"], ["generos_outro1", "outro1"], ["generos_outro2", "outro2"], ["generos_outro3", "outro3"], ["generos_outro4", "outro4"]]
    
    var generosSelecionados:[Array<Any>] = []
    
    @IBOutlet weak var collectionView_generos: UICollectionView!
    
    @IBAction func btnOK(_ sender: Any) {
        generosSelected()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        generosSelecionados.removeAll()
        for cell in cells {
            let generoCell = cell as! GeneroCollectionViewCell
            generosSelecionados.append([generoCell.label_genero.text!, generoCell.btnIsSelected])
        }
        print(generosSelecionados)
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
