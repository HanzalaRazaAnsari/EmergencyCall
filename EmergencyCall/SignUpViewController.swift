//
//  SignUpViewController.swift
//  EmergencyCall
//
//  Created by Axiom1 on 6/4/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SSBouncyButton

class SignUpViewController: UIViewController {
    @IBOutlet var btncheck: [UIButton]!
    
    let picker = UIDatePicker()
    var MaleorFemale:String!
    var anstext : String!
    
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var LastNameField: UITextField!
    
    @IBOutlet weak var EmailField: UITextField!
    
    @IBOutlet weak var BirthdayField: UITextField!
    
    @IBOutlet weak var Male: UILabel!
    @IBOutlet weak var Female: UILabel!

    
    @IBAction func SignUp(_ sender: Any) {
        
        
        
        if self.NameField.text?.isEmpty == true || self.LastNameField.text?.isEmpty == true || self.EmailField.text?.isEmpty == true || BirthdayField.text?.isEmpty == true || MaleorFemale.isEmpty == true {
            
            let alert = UIAlertController(title: nil, message: "Provide Complete Info", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            var SignUpdic = ["First Name" : self.NameField.text , "Last Name" : self.LastNameField.text , "Email": self.EmailField.text ," Date Of Birth" : BirthdayField.text , "Gender":self.MaleorFemale]
            var ref:DatabaseReference!
            ref = Database.database().reference()
            ref.child("Users").childByAutoId().setValue(SignUpdic)
            print(SignUpdic)
            self.performSegue(withIdentifier: "tomap", sender: self)
        }
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        BirthdayField.inputAccessoryView = toolbar
        BirthdayField.inputView = picker
        
        picker.datePickerMode = .date
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: picker.date)
        
        BirthdayField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
    }
    func uncheckAllButtons(){
        for btn in btncheck{
            btn.isSelected = false
        }
    }
  
    @IBAction func BtnCheckBtn(_ sender: UIButton) {
        
        self.uncheckAllButtons()
    
        sender.isSelected  = true
        
        
        if sender.tag == 0 {
            
            self.anstext = "Yes"
            self.MaleorFemale = self.Female.text
            
        }
        if sender.tag == 1 {
            
            self.anstext = "No"
            self.MaleorFemale = self.Male.text
            
    }
}

}
