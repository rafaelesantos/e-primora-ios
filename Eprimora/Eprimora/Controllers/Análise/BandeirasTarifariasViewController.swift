//
//  BandeirasTarifariasViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class BandeirasTarifariasViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mostrarButton: UIButton!
    
    var categoriaClasse: CategoriasClassesCodable?
    var bandeiraTarifarias: BandeirasTarifariasCodable?

    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseObserve.bandeiraTarifarias { (value) in
            
            self.bandeiraTarifarias = value
            self.descricaoLabel.text = value.descricao
            self.mostrarButton.setTitle("Mostrar mais", for: .normal)
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
        NetworkManager.sharedInstance.reachability.whenReachable = { (_) in
            
            FirebaseObserve.bandeiraTarifarias { (value) in
                
                self.bandeiraTarifarias = value
                self.descricaoLabel.text = value.descricao
                self.mostrarButton.setTitle("Mostrar mais", for: .normal)
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
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
        
        if self.descricaoLabel.numberOfLines == 3 {
            
            self.descricaoLabel.numberOfLines = 0
            self.mostrarButton.setTitle("Mostrar menos", for: .normal)
        }
        
        else {
            
            self.descricaoLabel.numberOfLines = 3
            self.mostrarButton.setTitle("Mostrar mais", for: .normal)
        }
    }
}

// MARK: Gesture Recognizer

extension BandeirasTarifariasViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}

// MARK: Table View

extension BandeirasTarifariasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = (self.bandeiraTarifarias?.bandeiras?.count ?? 0) == 0 ? .none : .singleLine
        return self.bandeiraTarifarias?.bandeiras?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BandeirasTarifariasTableViewCell", for: indexPath) as? BandeirasTarifariasTableViewCell else { return UITableViewCell() }
        
        let item = self.bandeiraTarifarias?.bandeiras?[indexPath.row]
        
        cell.selectionStyle = .none
        cell.tituloLabel.text = item?.titulo?.replacingOccurrences(of: ".", with: ",")
        cell.descricaoLabel.text = item?.descricao
        cell.imagemTarifa.tintColor = UIColor.hexStringToUIColor(hex: item?.cor ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.bandeiraTarifarias?.bandeiras?[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "EletrodomesticosViewController") as? EletrodomesticosViewController else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            controller.bandeiraTarifaria = item
            controller.categoriaClasse = self.categoriaClasse
            
            DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
        }
    }
}

// MARK: Table View Cell

public class BandeirasTarifariasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var imagemTarifa: UIImageView!
}

