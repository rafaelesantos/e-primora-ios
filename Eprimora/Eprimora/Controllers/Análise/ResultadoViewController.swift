//
//  ResultadoViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 30/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Blueprints
import BetterSegmentedControl

class ResultadoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoriaClasse: CategoriasClassesCodable?
    var bandeiraTarifaria: BandeirasCodable?
    var eletrodomesticos: [EletrodomesticoCodable] = []
    var images: [String: UIImage] = [:]
    var categorias = ["A", "B", "C", "D"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = VerticalBlueprintLayout(itemsPerRow: 2, height: 290, minimumInteritemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), stickyHeaders: false, stickyFooters: false)
        self.collectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: Button Action
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backInitButtonAction() {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: Gesture Recognizer

extension ResultadoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}

// MARK: Collection View

extension ResultadoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.eletrodomesticos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultadoCollectionViewCell", for: indexPath) as? ResultadoCollectionViewCell else { return UICollectionViewCell() }
        
        let item = self.eletrodomesticos[indexPath.row]
        
        cell.nameLabel.text = item.nome?.lowercased().capitalized
        cell.produtoImagem.image = self.images[item.imagem ?? ""]
        
        return cell
    }
}

// MARK: Collection View Cell

public class ResultadoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
}
