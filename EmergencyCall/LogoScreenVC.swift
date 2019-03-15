//
//  LogoScreenVC.swift
//  EmergencyCall
//
//  Created by Axiom1 on 5/12/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit
import SSBouncyButton

class LogoScreenVC: UIViewController {
    
    
   
    @IBAction func ContinueWithMobile(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segue1", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     

}


}
