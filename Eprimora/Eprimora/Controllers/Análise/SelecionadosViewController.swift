//
//  SelecionadosViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 30/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import McPicker

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
    var numberPicker: NumberPicker!

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
            
            controller.bandeiraTarifaria = self.bandeiraTarifaria
            controller.categoriaClasse = self.categoriaClasse
            controller.eletrodomesticos = self.eletrodomesticos
            controller.images = self.images
            
            DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
        }
    }
    
    @objc private func diasDeUsoButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            
            self.numberPicker = NumberPicker(delegate: self, maxNumber: 30)
            self.numberPicker.defaultSelectedNumber = self.eletrodomesticos[sender.tag].diasDeUso
            self.numberPicker.setIndexPath(indexPath: IndexPath(row: 0, section: sender.tag))
            self.numberPicker.heading = "Dias de Uso"
            self.numberPicker.bgGradients = [.secondarySystemBackground, .secondarySystemBackground]
            self.numberPicker.tintColor = .label
            
            self.present(self.numberPicker, animated: true, completion: nil)
        })
    }
    
    @objc private func tempoDeUsoButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            
            self.numberPicker = NumberPicker(delegate: self, maxNumber: 24)
            self.numberPicker.defaultSelectedNumber = self.eletrodomesticos[sender.tag].tempoDeUso
            self.numberPicker.setIndexPath(indexPath: IndexPath(row: 1, section: sender.tag))
            self.numberPicker.heading = "Tempo de Uso (Horas)"
            self.numberPicker.bgGradients = [.secondarySystemBackground, .secondarySystemBackground]
            self.numberPicker.tintColor = .label
            
            self.present(self.numberPicker, animated: true, completion: nil)
        })
    }
    
    @objc private func quantidadeButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            
            self.numberPicker = NumberPicker(delegate: self, maxNumber: 100)
            self.numberPicker.defaultSelectedNumber = self.eletrodomesticos[sender.tag].quantidade
            self.numberPicker.setIndexPath(indexPath: IndexPath(row: 2, section: sender.tag))
            self.numberPicker.heading = "Quantidade"
            self.numberPicker.bgGradients = [.secondarySystemBackground, .secondarySystemBackground]
            self.numberPicker.tintColor = .label
            
            self.present(self.numberPicker, animated: true, completion: nil)
        })
    }
    
    @objc private func potenciaButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            
            self.numberPicker = NumberPicker(delegate: self, maxNumber: self.eletrodomesticos[sender.tag].categorias?.last ?? 0)
            self.numberPicker.defaultSelectedNumber = self.eletrodomesticos[sender.tag].categorias?[self.eletrodomesticos[sender.tag].categoriaSelecionada] ?? 0
            self.numberPicker.setIndexPath(indexPath: IndexPath(row: 3, section: sender.tag))
            self.numberPicker.heading = "Potência"
            self.numberPicker.bgGradients = [.secondarySystemBackground, .secondarySystemBackground]
            self.numberPicker.tintColor = .label
            
            self.present(self.numberPicker, animated: true, completion: nil)
        })
    }
    
    @objc private func marcasButtonAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            
            var marcas: [[String]] = [
                (self.eletrodomesticos[sender.tag].marcas?.map({ (marcas) -> String in
                    return marcas.nome ?? ""
                    }) ?? [])
            ]
            
            marcas[0].append("Outra Marca")
            
            let mcPicker = McPicker(data: marcas)
            mcPicker.pickerBackgroundColor = .secondarySystemBackground
            mcPicker.toolbarBarTintColor = .systemBackground
            mcPicker.toolbarDoneButtonColor = #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1)
            mcPicker.toolbarCancelButtonColor = #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1)
            
            mcPicker.showAsPopover(fromViewController: self, sourceView: sender, sourceRect: sender.bounds, barButtonItem: nil) { [weak self] (selections: [Int : String]) -> Void in
                
                if let name = selections[0] {
                    
                    self?.eletrodomesticos[sender.tag].marcaSelecionada = name
                    self?.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
                }
            }
        })
    }
}

// MARK: Number Picker

extension SelecionadosViewController: NumberPickerDelegate {
    
    func selectedNumber(_ number: Int, _ tag: IndexPath) {
        
        if tag.row == 0 { self.eletrodomesticos[tag.section].diasDeUso = number }
        else if tag.row == 1 { self.eletrodomesticos[tag.section].tempoDeUso = number }
        else if tag.row == 2 { self.eletrodomesticos[tag.section].quantidade = number }
        else if tag.row == 3 { self.eletrodomesticos[tag.section].potenciaSelecionada = number }
        
        self.tableView.reloadRows(at: [IndexPath(row: tag.section, section: 0)], with: .none)
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
        cell.potenciaLabel.text = "\(item.potenciaSelecionada) Watts"
        cell.marcaLabel.text = item.marcaSelecionada
        
        cell.produtoImagem.image = self.images[item.imagem ?? ""]
        
        cell.diasButton.setTitle("\(item.diasDeUso)", for: .normal)
        cell.tempoButton.setTitle("\(item.tempoDeUso)", for: .normal)
        cell.quantidadeButton.setTitle("\(item.quantidade)", for: .normal)
        
        cell.diasButton.addTarget(self, action: #selector(self.diasDeUsoButtonAction(_:)), for: .touchUpInside)
        cell.tempoButton.addTarget(self, action: #selector(self.tempoDeUsoButtonAction(_:)), for: .touchUpInside)
        cell.quantidadeButton.addTarget(self, action: #selector(self.quantidadeButtonAction(_:)), for: .touchUpInside)
        cell.potenciaButton.addTarget(self, action: #selector(self.potenciaButtonAction(_:)), for: .touchUpInside)
        cell.marcaButton.addTarget(self, action: #selector(self.marcasButtonAction(_:)), for: .touchUpInside)
        
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
    
    func setTagButton(tag: Int) {
        
        self.diasButton.tag = tag
        self.tempoButton.tag = tag
        self.quantidadeButton.tag = tag
        self.marcaButton.tag = tag
        self.potenciaButton.tag = tag
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.categoriaLabel.layer.borderWidth = 5
        self.categoriaLabel.layer.borderColor = UIColor.systemBackground.cgColor
    }
}
