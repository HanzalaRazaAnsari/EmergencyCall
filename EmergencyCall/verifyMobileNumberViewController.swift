//
//  verifyMobileNumberViewController.swift
//  EmergencyCall
//
//  Created by Axiom1 on 5/21/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit
import FirebaseAuth
import SSBouncyButton

class verifyMobileNumberViewController: UIViewController , UITextFieldDelegate {
    
    @IBAction func EditNumber(_ sender: UIButton) {
        performSegue(withIdentifier: "segueback", sender: nil)
    }
    @IBOutlet weak var PhoneNumber: UILabel!
    
    @IBOutlet weak var TextField1: UITextField!
    
    @IBOutlet weak var TextField2: UITextField!
    
    @IBOutlet weak var TextField3: UITextField!
    
    @IBOutlet weak var TextField4: UITextField!
    
    @IBOutlet weak var TextField5: UITextField!
    
    @IBOutlet weak var TextField6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TextField1.delegate = self
        TextField2.delegate = self
        TextField3.delegate = self
        TextField4.delegate = self
        TextField5.delegate = self
        TextField6.delegate = self
        
        
        
        TextField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        TextField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        TextField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        TextField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        TextField5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        TextField6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        print(appdelegate.number)
        
        PhoneNumber.text! = appdelegate.number
        
    }
    
    @objc func textFieldDidChange (textField:UITextField)
    {
        let text = textField.text
        
        
        
        if text?.count == 1{
            switch textField {
            case TextField1:
                //  textField1.borderRect(forBounds: <#T##CGRect#>) = .red
                
                
                TextField2.becomeFirstResponder()
            case TextField2:
                TextField3.becomeFirstResponder()
            case TextField3:
                TextField4.becomeFirstResponder()
            case TextField4:
                TextField5.becomeFirstResponder()
            case TextField5:
                TextField6.becomeFirstResponder()
            case TextField6:
                userVerification()
                
                TextField6.resignFirstResponder()
                
            default:
                break
            }
        }
    }

    func userVerification(){
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential:PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode:"\(TextField1.text!)\(TextField2.text!)\(TextField3.text!)\(TextField4.text!)\(TextField5.text!)\(TextField6.text!)")
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error == nil {
                
                //  TMUser.loginUser? = TMUser(uID: (user?.uid)!)
                // TMUser.userLogin?.uID = Auth.auth().currentUser!.uid
                
                self.performSegue(withIdentifier: "segue3", sender: self)
                print("userID Be like \(Auth.auth().currentUser!.uid)")
                print("Successfull")
                //complete(nil)
            }
            else if error != nil {
                
                let alert = UIAlertController(title: "Error ", message: "The SMS verification code is Invalid", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true,completion: nil)
                print("error : \(String(describing: error?.localizedDescription))")
                // complete(error?.localizedDescription)
            }
        }
    }
    

}
