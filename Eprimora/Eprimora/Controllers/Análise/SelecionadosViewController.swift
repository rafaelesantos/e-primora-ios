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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelecionadosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelecionadosCell", for: indexPath) as? SelecionadosCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.nameLabel.text = names[selected[indexPath.row]].lowercased().capitalized
        cell.produtoImagem.image = UIImage(named: "\(selected[indexPath.row])")
        cell.segmented.setIndex(segmentIndex[selected[indexPath.row]], animated: true)
        cell.setSegmentedControl(segmented: cell.segmented, titles: ["A", "B", "C", "D"])
        
        return cell
    }
}

public class SelecionadosCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var segmented: BetterSegmentedControl!
    @IBOutlet weak var diasButton: UIButton!
    @IBOutlet weak var tempoButton: UIButton!
    @IBOutlet weak var quantidadeButton: UIButton!
    
    func setSegmentedControl(segmented: BetterSegmentedControl, titles: [String]) {
        
        segmented.segments = LabelSegment.segments(withTitles: titles, normalBackgroundColor: .systemBackground, normalFont: UIFont(name: "Avenir-Black", size: 17)!, normalTextColor: .label, selectedBackgroundColor: .secondarySystemBackground, selectedFont: UIFont(name: "Avenir-Black", size: 17)!, selectedTextColor: #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1))
        segmented.cornerRadius = 20
    }
}
