//
//  ViewController.swift
//  eprimora
//
//  Created by Rafael Escaleira on 08/04/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseModel.checkDatabase()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeApplianceSelectionVC") as? HomeApplianceSelectionVC
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller?.transitioningDelegate = transitionDelegate
        controller?.modalPresentationStyle = .custom
        controller?.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(controller!, animated: true, completion: nil)
    }
}
