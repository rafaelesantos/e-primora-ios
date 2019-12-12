//
//  EletrodomesticosViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 29/10/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class EletrodomesticosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var proximoButton: UIButton!
    
    var categoriaClasse: CategoriasClassesCodable?
    var bandeiraTarifaria: BandeirasCodable?
    var eletrodomesticos: [EletrodomesticoCodable] = []
    var images: [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        self.images = (UserDefaults.standard.value(forKey: "imagesEletrodomesticos") as? [String: Data] ?? [:]).mapValues({ (pngData) -> UIImage in
            
            return UIImage(data: pngData) ?? UIImage()
        })
        
        FirebaseObserve.eletrodomesticos { (value) in
            
            self.eletrodomesticos = value
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            
            URLRequest.downloadManyImages(urlsString: self.eletrodomesticos.map({ (eletrodomesticos) -> String in
                return eletrodomesticos.imagem ?? ""
            })) { (images) in
                
                self.images = images
                
                let imagesPNGData = self.images.mapValues({ (image) -> Data in
                    return (image.pngData() ?? Data())
                })
                
                UserDefaults.standard.set(imagesPNGData, forKey: "imagesEletrodomesticos")
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
        NetworkManager.sharedInstance.reachability.whenReachable = { (_) in
            
            FirebaseObserve.eletrodomesticos { (value) in
                
                self.eletrodomesticos = value
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                
                URLRequest.downloadManyImages(urlsString: self.eletrodomesticos.map({ (eletrodomesticos) -> String in
                    return eletrodomesticos.imagem ?? ""
                })) { (images) in
                    
                    self.images = images
                    
                    let imagesPNGData = self.images.mapValues({ (image) -> Data in
                        return (image.pngData() ?? Data())
                    })
                    
                    UserDefaults.standard.set(imagesPNGData, forKey: "imagesEletrodomesticos")
                    
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
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
    
    @objc func switchButtonAction(_ sender: UISwitch) {
        
        self.eletrodomesticos[sender.tag].estaSelecionado = sender.isOn
        self.proximoButton.alpha = self.eletrodomesticos.contains(where: { (eletrodomestico) -> Bool in
            return eletrodomestico.estaSelecionado
            }) == true ? 1 : 0
    }
    
    @objc func segmentedButtonAction(_ sender: BetterSegmentedControl) {
        
        self.eletrodomesticos[sender.tag].categoriaSelecionada = sender.index
        self.eletrodomesticos[sender.tag].potenciaSelecionada = self.eletrodomesticos[sender.tag].categorias?[sender.index] ?? 0
    }
    
    @IBAction func proximoButtonAction(_ sender: UIButton) {
        
        let item = self.eletrodomesticos.filter { (eletrodomestico) -> Bool in
            
            return eletrodomestico.estaSelecionado
        }
        
        let itemImages = self.images.filter { (image) -> Bool in
            
            return item.contains { (eletrodomestico) -> Bool in
                
                return eletrodomestico.imagem == image.key
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "SelecionadosViewController") as? SelecionadosViewController else { return }
        
        DispatchQueue.global(qos: .background).async {
            
            controller.bandeiraTarifaria = self.bandeiraTarifaria
            controller.categoriaClasse = self.categoriaClasse
            controller.eletrodomesticos = item
            controller.images = itemImages
            
            DispatchQueue.main.async { self.navigationController?.pushViewController(controller, animated: true) }
        }
    }
}

// MARK: Gesture Recognizer

extension EletrodomesticosViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        
        return false
    }
}

// MARK: Table View

extension EletrodomesticosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.eletrodomesticos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EletrodomesticosTableViewCell", for: indexPath) as? EletrodomesticosTableViewCell else { return UITableViewCell() }
        
        let item = self.eletrodomesticos[indexPath.row]
        
        cell.selectionStyle = .none
        cell.nomeLabel.text = item.nome?.lowercased().capitalized
        cell.produtoImagem.image = self.images[item.imagem ?? ""]
        
        cell.estaAtivo.tag = indexPath.row
        cell.segmented.tag = indexPath.row
        
        cell.setSegmentedControl(segmented: cell.segmented, titles: ["A", "B", "C", "D"])
        cell.segmented.setIndex(item.categoriaSelecionada, animated: true)
        cell.estaAtivo.isOn = item.estaSelecionado
        
        cell.estaAtivo.addTarget(self, action: #selector(self.switchButtonAction(_:)), for: .valueChanged)
        cell.segmented.addTarget(self, action: #selector(self.segmentedButtonAction(_:)), for: .valueChanged)
        
        self.segmentedButtonAction(cell.segmented)
        
        return cell
    }
}

// MARK: Table View Cell

public class EletrodomesticosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var produtoImagem: UIImageView!
    @IBOutlet weak var estaAtivo: UISwitch!
    @IBOutlet weak var segmented: BetterSegmentedControl!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setSegmentedControl(segmented: BetterSegmentedControl, titles: [String]) {
        
        segmented.segments = LabelSegment.segments(withTitles: titles, normalBackgroundColor: .systemBackground, normalFont: UIFont(name: "Avenir-Black", size: 17)!, normalTextColor: .label, selectedBackgroundColor: .secondarySystemBackground, selectedFont: UIFont(name: "Avenir-Black", size: 17)!, selectedTextColor: #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1))
        segmented.cornerRadius = 20
    }
}
