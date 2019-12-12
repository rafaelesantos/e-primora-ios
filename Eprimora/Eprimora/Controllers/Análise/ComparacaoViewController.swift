//
//  ComparacaoViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 30/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class ComparacaoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension ComparacaoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComparacaoTableViewCell", for: indexPath) as? ComparacaoTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
//        cell.nameLabel.text = names[selected[indexPath.row]].lowercased().capitalized
//        cell.produtoImagem.image = UIImage(named: "\(selected[indexPath.row])")
        cell.precoIdealLabel.text = "R$ 14,17"
        cell.seuPrecoLabel.text = "R$ 31,89"
        cell.economiaLabel.text = "R$ 17,71"
        cell.catIdealLabel.text = "A"
        cell.catSeuLabel.text = "D"
        
        return cell
    }
}

public class ComparacaoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var precoIdealLabel: UILabel!
    @IBOutlet weak var seuPrecoLabel: UILabel!
    @IBOutlet weak var economiaLabel: UILabel!
    @IBOutlet weak var catIdealLabel: UILabel!
    @IBOutlet weak var catSeuLabel: UILabel!
}

