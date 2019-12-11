//
//  ClassesConsumoViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 29/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class ClassesConsumoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let names: [String] = ["Residencial sem benefício", "Residencial BR (consumo até 30 kWh)", "Residencial BR (consumo de 30 a 100 kWh)", "Residencial BR (consumo de 101 a 220 kWh)", "Residencial BR (consumo acima de 220 kWh)", "Rural", "Rural Irrigação", "Cooperativa de Eletrif. Rural", "Serviço de Irrigação", "Comercial Serviços e Outros", "Industrial", "Poderes Públicos", "Serviço Público"]
    let precos: [String] = ["R$ 0.49208", "R$ 0.16287", "R$ 0.27921", "R$ 0.41880", "R$ 0.46534", "R$ 0.34446", "R$ 0.11367", "R$ 0.34136", "R$ 0.29525", "R$ 0.49208", "R$ 0.49208", "R$ 0.49208", "R$ 0.41827"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension ClassesConsumoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassesConsumoTableViewCell", for: indexPath) as? ClassesConsumoTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.precoLabel.text = self.precos[indexPath.row]
        cell.nameLabel.text = self.names[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async { self.performSegue(withIdentifier: "EletrodomesticosViewController", sender: nil) }
    }
}

public class ClassesConsumoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
