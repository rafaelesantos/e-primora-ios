//
//  PresentationViewController.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var sobreEprimora: SobreEprimoraCodable?
    var images: [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.images = (UserDefaults.standard.value(forKey: "imagesPresentation") as? [String: Data] ?? [:]).mapValues({ (pngData) -> UIImage in
            
            return UIImage(data: pngData) ?? UIImage()
        })
        
        FirebaseObserve.sobreEprimora { (value) in
            
            self.sobreEprimora = value
            self.descricaoLabel.text = value.descricao
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            
            URLRequest.downloadManyImages(urlsString: self.sobreEprimora?.vantagens?.map({ (vantagens) -> String in
                return vantagens.imagem ?? ""
            }) ?? []) { (images) in
                
                self.images = images
                
                let imagesPNGData = self.images.mapValues({ (image) -> Data in
                    return (image.pngData() ?? Data())
                })
                
                UserDefaults.standard.set(imagesPNGData, forKey: "imagesPresentation")
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
        NetworkManager.sharedInstance.reachability.whenReachable = { (_) in
            
            FirebaseObserve.sobreEprimora { (value) in
                
                self.sobreEprimora = value
                self.descricaoLabel.text = value.descricao
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                
                URLRequest.downloadManyImages(urlsString: self.sobreEprimora?.vantagens?.map({ (vantagens) -> String in
                    return vantagens.imagem ?? ""
                }) ?? []) { (images) in
                    
                    self.images = images
                    
                    let imagesPNGData = self.images.mapValues({ (image) -> Data in
                        return (image.pngData() ?? Data())
                    })
                    
                    UserDefaults.standard.set(imagesPNGData, forKey: "imagesPresentation")
                    
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: Table View

extension PresentationViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //tableView.separatorStyle = (self.sobreEprimora?.vantagens?.count ?? 0) == 0 ? .none : .singleLine
        
        return self.sobreEprimora?.vantagens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentationTableViewCell", for: indexPath) as? PresentationTableViewCell else { return UITableViewCell() }
        
        let item = self.sobreEprimora?.vantagens?[indexPath.row]
        
        cell.selectionStyle = .none
        cell.titlePresentation.text = item?.titulo
        cell.descriptionPresentation.text = item?.descricao
        cell.backgroundImage.image = self.images[item?.imagem ?? ""]
        
        return cell
    }
}

// MARK: Table View Cell

public class PresentationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titlePresentation: UILabel!
    @IBOutlet weak var descriptionPresentation: UILabel!
}
