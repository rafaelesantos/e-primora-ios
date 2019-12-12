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

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = HorizontalBlueprintLayout(itemsPerRow: 1, height: self.collectionView.frame.height - 40, minimumInteritemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), stickyHeaders: false, stickyFooters: false)
        self.collectionView.collectionViewLayout = layout
    }
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backInitButtonAction() {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultadoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultadoCollectionViewCell", for: indexPath) as? ResultadoCollectionViewCell else { return UICollectionViewCell() }
        
//        cell.nameLabel.text = names[selected[indexPath.row]].lowercased().capitalized
//        cell.produtoImagem.image = UIImage(named: "\(selected[indexPath.row])")
//        cell.segmented.setIndex(segmentIndex[selected[indexPath.row]], animated: true)
//        cell.setSegmentedControl(segmented: cell.segmented, titles: ["A", "B", "C", "D"])
        
        return cell
    }
}

public class ResultadoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var segmented: BetterSegmentedControl!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    
    func setSegmentedControl(segmented: BetterSegmentedControl, titles: [String]) {
        
        segmented.segments = LabelSegment.segments(withTitles: titles, normalBackgroundColor: .systemBackground, normalFont: UIFont(name: "Avenir-Black", size: 17)!, normalTextColor: .label, selectedBackgroundColor: .secondarySystemBackground, selectedFont: UIFont(name: "Avenir-Black", size: 17)!, selectedTextColor: #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1))
        segmented.cornerRadius = 20
    }
}
