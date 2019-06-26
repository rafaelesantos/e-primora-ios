//
//  HomeApplianceSelectionModel.swift
//  eprimora
//
//  Created by Rafael Escaleira on 24/06/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension HomeApplianceSelectionVC: UITableViewDataSource, UITableViewDelegate, NumberPickerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeApplianceSelectionCell", for: indexPath) as? HomeApplianceSelectionCell else { return UITableViewCell() }
        let item = self.products[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setCell(productName: item.productName, productConvenient: item.productConvenient, productImageData: item.productImage ?? NSData())
        cell.setTitleButton(titlePower: "\(self.setProducts[indexPath.row][0])", titleAmount: "\(self.setProducts[indexPath.row][1])", titleHour: "\(self.setProducts[indexPath.row][2])", titleDay: "\(self.setProducts[indexPath.row][3])")
        //cell.setButtonBackgroundColor(isShow: self.setButtons[indexPath.row])
        cell.setIndexButton(index: indexPath.row)
        
        cell.powerButton.addTarget(self, action: #selector(self.openNumberPicker), for: .touchUpInside)
        cell.amountButton.addTarget(self, action: #selector(self.openNumberPicker), for: .touchUpInside)
        cell.hourButton.addTarget(self, action: #selector(self.openNumberPicker), for: .touchUpInside)
        cell.dayButton.addTarget(self, action: #selector(self.openNumberPicker), for: .touchUpInside)
        
        cell.selectSwitch.tag = indexPath.row
        cell.selectSwitch.addTarget(self, action: #selector(self.switchChanged), for: .valueChanged)
        cell.selectSwitch.setOn(self.stateSwitch[cell.selectSwitch.tag])
        
        if #available(iOS 13.0, *) { cell.productView.backgroundColor = cell.selectSwitch.isOn ? UIColor.secondarySystemGroupedBackground : #colorLiteral(red: 0.9995375276, green: 0.6704526544, blue: 0.6545208097, alpha: 1) }
        else { cell.productView.backgroundColor = cell.selectSwitch.isOn ? .white : #colorLiteral(red: 0.9996131063, green: 0.9357891083, blue: 0.9316421151, alpha: 1) }
        
        return cell
    }
    
    public func getHomeAppliance() -> [HomeAppliancesDatabase] {
        
        return HomeAppliancesDatabase.query().fetch() as? [HomeAppliancesDatabase] ?? []
    }
    
    @objc func switchChanged(_ sender : BaseSwitch){
        
        if sender.isOn { sender.setOn(true); self.stateSwitch[sender.tag] = true }
            
        else {
            
            sender.setOn(false); self.stateSwitch[sender.tag] = false
            self.products.remove(at: sender.tag)
            self.setProducts.remove(at: sender.tag)
            self.stateSwitch.remove(at: sender.tag)
            self.setButtons.remove(at: sender.tag)
            
            self.tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { self.tableView.reloadData() }
        }
    }
    
    @objc func openNumberPicker(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.2) { sender.transform = CGAffineTransform.identity }
            var numberPicker: NumberPicker!
            
            if sender.restorationIdentifier == "Potência" {
                
                numberPicker = NumberPicker(delegate: self, maxNumber: self.products[sender.tag].productMaxPower?.intValue ?? 0)
                numberPicker.defaultSelectedNumber = self.setProducts[sender.tag][0]
                numberPicker.setIndexPath(indexPath: .init(row: 0, section: sender.tag))
            }
            
            if sender.restorationIdentifier == "Quantidade" {
                
                numberPicker = NumberPicker(delegate: self, maxNumber: 100)
                numberPicker.defaultSelectedNumber = self.setProducts[sender.tag][1]
                numberPicker.setIndexPath(indexPath: .init(row: 1, section: sender.tag))
                sender.backgroundColor = UIColor.systemOrange
            }
            
            if sender.restorationIdentifier == "Horas por Dia" {
                
                numberPicker = NumberPicker(delegate: self, maxNumber: 24)
                numberPicker.defaultSelectedNumber = self.setProducts[sender.tag][2]
                numberPicker.setIndexPath(indexPath: .init(row: 2, section: sender.tag))
                sender.backgroundColor = UIColor.systemPurple
            }
            
            if sender.restorationIdentifier == "Dias por Mês" {
                
                numberPicker = NumberPicker(delegate: self, maxNumber: 31)
                numberPicker.defaultSelectedNumber = self.setProducts[sender.tag][3]
                numberPicker.setIndexPath(indexPath: .init(row: 3, section: sender.tag))
                sender.backgroundColor = #colorLiteral(red: 0.3843137255, green: 0.7294117647, blue: 0.2784313725, alpha: 1)
            }
            
            numberPicker.bgGradients = [(sender.backgroundColor ?? UIColor()), (sender.backgroundColor ?? UIColor())]
            numberPicker.tintColor = .white
            numberPicker.heading = sender.restorationIdentifier ?? ""
            sender.setTitleColor(.white, for: .normal)
            
            self.present(numberPicker, animated: true, completion: nil)
        })
    }
    
    func selectedNumber(_ number: Int, _ tag: IndexPath) {
        
        self.setProducts[tag.section][tag.row] = number
        self.setButtons[tag.section][tag.row] = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { self.tableView.reloadData() }
    }
}
