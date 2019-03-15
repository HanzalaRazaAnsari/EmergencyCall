//
//  HistoryViewController.swift
//  EmergencyCall
//
//  Created by HanZala RaZa on 6/13/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    
    @IBAction func backbutton(_ sender: Any) {
        self.performSegue(withIdentifier: "search", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
}


}
