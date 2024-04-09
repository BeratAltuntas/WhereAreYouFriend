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
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var pageCounterLabel: UILabel!
    var denee: String?
    var loginPageCounter: Int = 1 {
        didSet{
            var headerTitleText = ""
            var firstLabelText = ""
            var secondLabelText = ""
            switch(loginPageCounter) {
            case 1:
                headerTitleText = "Login"
                firstLabelText = "Name"
                secondLabelText = "Username"
                break
            case 2:
                headerTitleText = "Login"
                firstLabelText = "Email"
                secondLabelText = "Password"
                break
            case 3:
                headerTitleText = "Login"
                firstLabelText = "Name"
                secondLabelText = "Username"
                break
            case 4:
                headerTitleText = "Login"
                firstLabelText = "Name"
                secondLabelText = "Username"
                break
            default:
                headerTitleText = ""
                break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
                self?.headerTitleLabel.text = headerTitleText
                self?.pageCounterLabel.text = "\(self!.loginPageCounter) of 4"
                
                self?.firstTextLabel.text = firstLabelText
                self?.firstTextField.placeholder = "Your \(firstLabelText)"
                self?.firstTextField.text = ""
                
                self?.secondTextLabel.text = secondLabelText
                self?.secondTextField.placeholder = "Your \(secondLabelText)"
                self?.secondTextField.text = ""
                
                self?.loadingIndicatorView.stopAnimating()
            }
        }
    }
    
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
        continueButtonBottomConstraint.constant = 20
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
            loadingIndicatorView.startAnimating()
            loginPageCounter += 1
        }
    }
    
    func checkTextFieldValid(textField: UITextField!)-> Bool {
        if let textField = textField {
            if(!textField.text!.isEmpty &&
               !textField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoginScreen2" {
            guard let vc = segue.destination as? LoginViewController else { return }
            // sonraki ekrana verilecek model bloğu
        }
    }
    
    func loadingLoginItems() {
        
    }
}

extension LoginViewController: UITextViewDelegate {

}
