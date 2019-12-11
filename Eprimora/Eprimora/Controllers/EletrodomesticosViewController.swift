//
//  EletrodomesticosViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 29/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import BetterSegmentedControl

let names: [String] = ["ar condicionado", "despertador", "liquidificador 1", "liquidificador 2", "liquidificador", "máquina de café", "encrespador", "lava-louças", "depilador", "extrator", "ventilador", "vaporizador de alimentos", "geladeira", "secador de cabelo", "ferro", "espremedor", "chaleira", "luminária, abajur", "moedor de carne", "forno de micro-ondas", "misturador 1", "misturador", "multi fogão", "reprodutor de música", "alto-falante de música", "forno", "câmera fotografica", "impressora", "geladeira", "máquina de costura", "barbeador 1", "barbeador", "fogão", "Telefone", "televisão", "torradeira", "escova de dente", "aspirador de pó 1", "aspirador de pó", "máquina de lavar"]
var segmentIndex: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var isOn: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var selected: [Int] = []

class EletrodomesticosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func switchButtonAction(_ sender: UISwitch) {
        
        isOn[sender.tag] = sender.isOn == false ? 0 : 1
        
        if sender.isOn == true { selected.append(sender.tag) }
        else { selected.removeFirst(sender.tag) }
    }
    
    @objc func segmentedButtonAction(_ sender: BetterSegmentedControl) {
        
        segmentIndex[sender.tag] = sender.index
    }
}

extension EletrodomesticosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EletrodomesticosTableViewCell", for: indexPath) as? EletrodomesticosTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.nameLabel.text = names[indexPath.row].lowercased().capitalized
        cell.produtoImagem.image = UIImage(named: "\(indexPath.row)")
        
        cell.isAtivo.tag = indexPath.row
        cell.segmented.tag = indexPath.row
        
        cell.segmented.setIndex(segmentIndex[indexPath.row], animated: true)
        cell.setSegmentedControl(segmented: cell.segmented, titles: ["A", "B", "C", "D"])
        cell.isAtivo.isOn = isOn[indexPath.row] == 0 ? false : true
        
        cell.isAtivo.addTarget(self, action: #selector(self.switchButtonAction(_:)), for: .touchUpInside)
        cell.segmented.addTarget(self, action: #selector(self.segmentedButtonAction(_:)), for: .valueChanged)
        
        return cell
    }
}

public class EletrodomesticosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var isAtivo: UISwitch!
    @IBOutlet weak var segmented: BetterSegmentedControl!
    
    func setSegmentedControl(segmented: BetterSegmentedControl, titles: [String]) {
        
        segmented.segments = LabelSegment.segments(withTitles: titles, normalBackgroundColor: .systemBackground, normalFont: UIFont(name: "Avenir-Black", size: 17)!, normalTextColor: .label, selectedBackgroundColor: .secondarySystemBackground, selectedFont: UIFont(name: "Avenir-Black", size: 17)!, selectedTextColor: #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1))
        segmented.cornerRadius = 20
    }
}
