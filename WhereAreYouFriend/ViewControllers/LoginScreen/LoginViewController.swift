//
//  LoginViewController.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 2.03.2024.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var continueButton: CustomUIButton!
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    var denee: String?
    
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillAppear(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc
    func keyboardWillAppear(notification: NSNotification?) {

        guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        

        continueButtonBottomConstraint.constant = keyboardHeight + 20
    }
    
    @IBAction func editBegin(_ sender: Any) {

        
    }
    
    @IBAction func editDidEnd(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    @IBAction func primaryButton(_ sender: Any) {
        if let textField = sender as? UITextField {
            if textField.tag ==  1 {
                /// name textfield alanı
                self.firstTextField.resignFirstResponder()
                self.secondTextField.becomeFirstResponder()
                
            } else if textField.tag == 2 {
                /// email  textfield alanı
                self.secondTextField.resignFirstResponder()
                textField.endEditing(true)
                
            }
        }
    }
    
    @IBAction func ContinueButton_TUI(_ sender: Any) {
        if(checkTextFieldValid(textField: firstTextField) && checkTextFieldValid(textField: secondTextField)) {
            performSegue(withIdentifier: "goToLoginScreen2", sender: self)
        }
    }
    
    func checkTextFieldValid(textField: UITextField!)-> Bool {
        
        if(textField.text!.isEmpty &&
           textField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoginScreen2" {
            guard let vc = segue.destination as? LoginViewController else { return }
            // sonraki ekrana verilecek model bloğu
        }
    }
}

extension LoginViewController: UITextViewDelegate {

}
