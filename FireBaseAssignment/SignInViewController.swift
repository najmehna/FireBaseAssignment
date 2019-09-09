//
//  ViewController.swift
//  FireBaseAssignment
//
//  Created by najmeh nasiriyani on 2019-09-07.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController , UITextFieldDelegate{
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        guard var phoneNo = phoneNumber.text else{return}
        if phoneNumber.hasText{
        phoneNo = "+1" + phoneNo
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNo, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                UserDefaults.standard.set(verificationID, forKey: "verificationID")
            } else{
                print("there was something wrong \(error!.localizedDescription)")
                
            }
        }
        }
    }
    
    @IBAction func verifyBtnClicked(_ sender: UIButton) {
        guard let myCode = code.text else{ return }
        
        let myCreditential = PhoneAuthProvider.provider().credential(withVerificationID: UserDefaults.standard.string(forKey: "verificationID")!, verificationCode: myCode)
        Auth.auth().signInAndRetrieveData(with: myCreditential) { (result, error) in
            if error == nil{
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }else{
                print("Error signing the user in \(error!.localizedDescription)")
            }
        }
    }
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

}

