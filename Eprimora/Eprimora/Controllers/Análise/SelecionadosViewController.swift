//
//  SelecionadosViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 30/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class SelecionadosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mostrarButton: UIButton!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var proximoButton: UIButton!
    
    var categoriaClasse: CategoriasClassesCodable?
    var bandeiraTarifaria: BandeirasCodable?
    var eletrodomesticos: [EletrodomesticoCodable] = []
    var images: [String: UIImage] = [:]
    var categorias = ["A", "B", "C", "D"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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
    
    @IBAction func mostrarButtonAction(_ sender: Any) {
        
        if self.descricaoLabel.text == "" {
            
            self.descricaoLabel.text = "A potência média é pré-definida baseada na categoria selecionada, caso a sua seja diferente você poderá informá-la."
            self.mostrarButton.setTitle("Entendi", for: .normal)
        }
        
        else {
            
            self.descricaoLabel.text = ""
            self.mostrarButton.setTitle("Como funciona a medida de potência ?", for: .normal)
        }
    }
    
    @IBAction func proximoButtonAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "ResultadoViewController") as? ResultadoViewController else { return }
        
        DispatchQueue.global(qos: .background).async {
            
//            controller.bandeiraTarifaria = self.bandeiraTarifaria
//            controller.categoriaClasse = self.categoriaClasse
//            controller.eletrodomesticos = item
//            controller.images = itemImages
            
            DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
        }
    }
}

// MARK: Gesture Recognizer

extension SelecionadosViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}

// MARK: Table View

extension SelecionadosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.eletrodomesticos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelecionadosCell", for: indexPath) as? SelecionadosCell else { return UITableViewCell() }
        
        let item = self.eletrodomesticos[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setTagButton(tag: indexPath.row)
        cell.nameLabel.text = item.nome?.lowercased().capitalized
        cell.categoriaLabel.text = self.categorias[item.categoriaSelecionada]
        cell.potenciaLabel.text = "\(item.categorias?[item.categoriaSelecionada] ?? 0) Watts"
        cell.produtoImagem.image = self.images[item.imagem ?? ""]
        
        cell.diasButton.setTitle("\(item.diasDeUso)", for: .normal)
        cell.tempoButton.setTitle("\(item.tempoDeUso)", for: .normal)
        cell.quantidadeButton.setTitle("\(item.quantidade)", for: .normal)
        
        return cell
    }
}

// MARK: Table View Cell

public class SelecionadosCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var diasButton: UIButton!
    @IBOutlet weak var tempoButton: UIButton!
    @IBOutlet weak var quantidadeButton: UIButton!
    @IBOutlet weak var categoriaLabel: UILabel!
    @IBOutlet weak var marcaLabel: UILabel!
    @IBOutlet weak var potenciaLabel: UILabel!
    @IBOutlet weak var marcaButton: UIButton!
    @IBOutlet weak var potenciaButton: UIButton!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.categoriaLabel.layer.borderWidth = 5
        self.categoriaLabel.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    func setTagButton(tag: Int) {
        
        self.diasButton.tag = tag
        self.tempoButton.tag = tag
        self.quantidadeButton.tag = tag
        self.marcaButton.tag = tag
        self.potenciaButton.tag = tag
    }
}
