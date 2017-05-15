//
//  GenerosViewController.swift
//  AppTeatro
//
//  Created by MyMac on 5/15/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class GenerosViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{

    @IBAction func btnOK(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let imagens = ["generos_comedia", "generos_drama", "generos_suspense", "generos_outro1", "generos_outro2", "generos_outro3", "generos_outro4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneroCell", for: indexPath) as! GeneroCollectionViewCell
        cell.imgView_genero.image = UIImage(named: imagens[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let largura = (collectionView.frame.size.width-12*2)/3
        
        return CGSize(width: largura, height: largura)
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
