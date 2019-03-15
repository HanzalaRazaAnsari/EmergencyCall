//
//  MenuViewController.swift
//  EmergencyCall
//
//  Created by Axiom1 on 6/7/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuViewController: UIViewController {
    
    
    


    @IBAction func Home(_ sender: Any) {
//        performSegue(withIdentifier: "map", sender: nil)
    }
    
    
    @IBAction func History(_ sender: Any) {
        performSegue(withIdentifier: "history", sender: nil)
        
    }
    
    
    @IBAction func Logout(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                
                let uistoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                uistoryboard.instantiateInitialViewController()
                let loginviewcontroller :UIViewController = uistoryboard.instantiateViewController(withIdentifier: "mainscreen")
                self.present(loginviewcontroller, animated: true, completion: nil)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(logout)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

}
