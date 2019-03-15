





import UIKit
import CountryPickerView
import FirebaseAuth
import SSBouncyButton

class SecondViewController: UIViewController , UITextFieldDelegate{
   
    @IBOutlet weak var ImageView: UIImageView!
    let appdelegate = UIApplication.shared.delegate as!AppDelegate
    let cp = CountryPickerView(frame:CGRect(x: 0, y: 0, width: 120, height: 20))
 
    @IBOutlet weak var CountryPickerViewField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryPickerViewField.delegate = self
      
       CountryPickerViewField.leftView = cp
        CountryPickerViewField.leftViewMode = .always
        
        
     
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
    let allowedCharacters = "+1234567890"
    let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
    let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    @IBAction func Back(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: nil)
    }
    
//  let cpv = CountryPickerView.self
//
//    var code1:String = ""
   
    
   
    func UserAuthentication(number : String){
        self.CountryPickerViewField.text = number
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID,error) in
    
            if let error = error {
                print("error \(error.localizedDescription)")
                return
            }
            UserDefaults.standard.set(verificationID, forKey:"authVerificationID")
            UserDefaults.standard.synchronize()
        
        }
    }
  
    
    
    
    


    @IBAction func Continue(_ sender: Any) {
            
       
         if CountryPickerViewField.text! == "" {

            let alert = UIAlertController(title: "", message: "Required Field", preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))

            self.present(alert , animated: true , completion: nil)


        } else {



            let alert = UIAlertController(title: "Is your mobile number correct?", message: "\(self.cp.selectedCountry.phoneCode)\(self.CountryPickerViewField.text!)"
                , preferredStyle: UIAlertControllerStyle.alert)

           

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                
                alert.dismiss(animated: true, completion: nil)
                self.appdelegate.number = "\(self.cp.selectedCountry.phoneCode)\(self.CountryPickerViewField.text!)"
                self.appdelegate.number1 = "\(self.CountryPickerViewField.text!)"
                self.UserAuthentication(number:"\(self.cp.selectedCountry.phoneCode)\(self.CountryPickerViewField.text!)" )
                  self.performSegue(withIdentifier: "segue2", sender: nil)
            }))
            
             alert.addAction(UIAlertAction(title: "edit", style: UIAlertActionStyle.default, handler: nil))

            self.present(alert , animated: true , completion: nil)




    }
        
        }
    override func viewDidAppear(_ animated: Bool) {
        self.CountryPickerViewField.text = self.appdelegate.number1
       
    
        }
    }





