


import UIKit
import CTKFlagPhoneNumber


class ViewController: UIViewController , UITextFieldDelegate {


    @IBOutlet weak var ContactField: CTKFlagPhoneNumberTextField!
        
        
  


    override func viewDidLoad() {
        super.viewDidLoad()
       
        ContactField.delegate = self
//        countryList.delegate = self
//        PhoneNumber.delegate = self
//        CountryCode.delegate = self
        
            
          ContactField = CTKFlagPhoneNumberTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))
        
        
        // You can change the choosen flag
        ContactField.setFlag(with: "PK")
        
        // You can change the phone number, that will update automatically the flag image
        ContactField.set(phoneNumber: "0600000001")
        
        // You can also get the phone number to E164 format, the country phone code and the raw phone number
        print(ContactField.getFormattedPhoneNumber()) // Output: +33600000001
        print(ContactField.getCountryPhoneCode()) // Output: +33
        print(ContactField.getRawPhoneNumber())


    }

//    @IBOutlet weak var flagimage: UITextField!
//    var countryList = CountryList()
//    func selectedCountry(country: Country) {
//        print(country.name! as String)
//        print(country.flag! as String)
//        print(country.countryCode as String)
//        print(country.phoneExtension as String)
//
//        CountryCode.text = country.phoneExtension
//        flagimage.text = country.flag


    }
//
//
//    @IBAction func dropdownmenu(_ sender: Any) {
//        let navController = UINavigationController(rootViewController: countryList)
//        self.present(navController , animated: true, completion: nil)



//
//    @IBOutlet weak var PhoneNumber: UITextField!
//    @IBOutlet weak var CountryCode: UITextField!
//
//
//
//
//
//
//
//    @IBAction func Continue(_ sender: Any) {
//
//        if PhoneNumber.text == "" && CountryCode.text == "" {
//
//
//            let alert = UIAlertController(title: "", message: "Required Field", preferredStyle: UIAlertControllerStyle.alert)
//
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
//
//            self.present(alert , animated: true , completion: nil)
//
//
//
//        } else {
//
//
//        let alert = UIAlertController(title: "", message: "Is your mobile number correct? \(CountryCode.text) "+" \(PhoneNumber.text)", preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title: "edit", style: UIAlertActionStyle.default, handler: nil))
//
//        alert.addAction(UIAlertAction(title: "yes", style: UIAlertActionStyle.default, handler: nil))
//
//              self.present(alert , animated: true , completion: nil)
//    }
//
//
//}




