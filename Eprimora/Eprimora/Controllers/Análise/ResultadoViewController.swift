//
//  ResultadoViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 30/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Blueprints

class ResultadoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalContaLabel: UILabel!
    
    var categoriaClasse: CategoriasClassesCodable?
    var bandeiraTarifaria: BandeirasCodable?
    var eletrodomesticos: [EletrodomesticoCodable] = []
    var images: [String: UIImage] = [:]
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let itemsPerRow: CGFloat = (self.view.frame.width / 162).rounded(.down)
        let height: CGFloat = 200
        let layout = VerticalBlueprintLayout(itemsPerRow: itemsPerRow, height: height, minimumInteritemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), stickyHeaders: false, stickyFooters: false)
        self.collectionView.collectionViewLayout = layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calcularContaEnergia()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func calcularContaEnergia() {
        
        for index in 0 ... (self.eletrodomesticos.count - 1) {
            
            autoreleasepool {
                
                let eletrodomestico = self.eletrodomesticos[index]
                
                let kWh = (Double(eletrodomestico.potenciaSelecionada) / 1000) * Double(eletrodomestico.quantidade)
                
                let consumoDiario = kWh * Double(eletrodomestico.tempoDeUso)
                let consumoMensal = consumoDiario * Double(eletrodomestico.diasDeUso)
                
                let acrescimoDiario = consumoDiario * Double(self.bandeiraTarifaria?.preco?.replacingOccurrences(of: "R$ ", with: "") ?? "0")!
                let acrescimoMensal = consumoMensal * Double(self.bandeiraTarifaria?.preco?.replacingOccurrences(of: "R$ ", with: "") ?? "0")!
                
                let valorConsumoDiario = consumoDiario * Double(self.categoriaClasse?.valor?.replacingOccurrences(of: "R$ ", with: "") ?? "0")!
                let valorConsumoMensal = consumoMensal * Double(self.categoriaClasse?.valor?.replacingOccurrences(of: "R$ ", with: "") ?? "0")!
                
                self.eletrodomesticos[index].totalConsumoDiario = valorConsumoDiario + acrescimoDiario
                self.eletrodomesticos[index].totalConsumoMensal = valorConsumoMensal + acrescimoMensal
            }
        }
        
        self.totalContaLabel.text = String(format: "R$ %.2f", self.eletrodomesticos.map({ (eletrodomestico) -> Double in
        return eletrodomestico.totalConsumoMensal
            }).reduce(0, +)).replacingOccurrences(of: ".", with: ",")
        self.collectionView.reloadData()
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
        cell.valorLabel.text = String(format: "R$ %.2f", item.totalConsumoMensal).replacingOccurrences(of: ".", with: ",")
        
        return cell
    }
}

// MARK: Collection View Cell

public class ResultadoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var valorLabel: UILabel!
}
