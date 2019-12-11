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
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mostrarButton: UIButton!
    
    var classesDeConsumo: ClassesDeConsumoCodable?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        FirebaseObserve.classesDeConsumo { (value) in
            
            self.classesDeConsumo = value
            self.descricaoLabel.text = value.descricao
            self.mostrarButton.setTitle("Mostrar mais", for: .normal)
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
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

extension ClassesConsumoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}

// MARK: Table View

extension ClassesConsumoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = (self.classesDeConsumo?.categoriasClasses?.count ?? 0) == 0 ? .none : .singleLine
        return self.classesDeConsumo?.categoriasClasses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassesConsumoTableViewCell", for: indexPath) as? ClassesConsumoTableViewCell else { return UITableViewCell() }
        
        let item = self.classesDeConsumo?.categoriasClasses?[indexPath.row]
        
        cell.selectionStyle = .none
        cell.precoLabel.text = item?.valor?.replacingOccurrences(of: ".", with: ",")
        cell.nameLabel.text = item?.descricao
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.classesDeConsumo?.categoriasClasses?[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "BandeirasTarifariasViewController") as? BandeirasTarifariasViewController else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            controller.categoriaClasse = item
            
            DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
        }
    }
}

// MARK: Table View Cell

public class ClassesConsumoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
