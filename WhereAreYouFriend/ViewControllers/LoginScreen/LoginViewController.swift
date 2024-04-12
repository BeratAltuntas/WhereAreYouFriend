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
    var loginPropertiesModel = [LoginScreenPropertiesModel()]
    
    var loginPageCounter: Int = 1 {
        didSet{
    
            var headerTitleText = ""
            switch(loginPageCounter) {
            case 1:
                if loginPropertiesModel.count < 1 {
                    loginPropertiesModel.append(LoginScreenPropertiesModel(firstTextFieldTitle: "Name", firstTextFieldPlaceHolder: "Your Name", secondtTextFieldTitle: "Username", secondTextFieldPlaceHolder: "Your Username", pageNumber: loginPageCounter))
                }
                headerTitleText = "Login"
                break
            case 2:
                if loginPropertiesModel.count < 2 {
                    loginPropertiesModel.append(LoginScreenPropertiesModel(firstTextFieldTitle: "Email", firstTextFieldPlaceHolder: "Your Email", secondtTextFieldTitle: "Password", secondTextFieldPlaceHolder: "Your Password", pageNumber: loginPageCounter))
                }
                
                headerTitleText = "Login"
                break
            case 3:
                headerTitleText = "Login"
                break
            case 4:
                headerTitleText = "Login"
                break
            default:
                headerTitleText = ""
                break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(loginPageCounter) - 1.0)) {[weak self] in
                self?.headerTitleLabel.text = headerTitleText
                self?.pageCounterLabel.text = "\(self?.loginPropertiesModel[self!.loginPageCounter-1].pageNumber ?? 1) of 4"
                
                self?.firstTextLabel.text = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldTitle
                self?.firstTextField.placeholder = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldPlaceHolder
                self?.firstTextField.text = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldText
                
                self?.secondTextLabel.text = self?.loginPropertiesModel[self!.loginPageCounter-1].secondtTextFieldTitle
                self?.secondTextField.placeholder = self?.loginPropertiesModel[self!.loginPageCounter-1].secondTextFieldPlaceHolder
                self?.secondTextField.text = self?.loginPropertiesModel[self!.loginPageCounter-1].secondtTextFieldText
                
                self?.loadingIndicatorView.stopAnimating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillAppear(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        loginPropertiesModel = [LoginScreenPropertiesModel()]
        loginPropertiesModel.removeAll()
        loginPageCounter = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    
    }

   @objc func back(sender: UIBarButtonItem) {
       loginPropertiesModel[loginPageCounter-1].pageNumber -= 1
       if loginPropertiesModel[loginPageCounter-1].pageNumber > 0 {
           loginPageCounter -= 1
       } else {
           _ = navigationController?.popViewController(animated: true)
       }
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

        var keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        if keyboardHeight < 0 {
            keyboardHeight = CGFloat.zero
        }
        continueButtonBottomConstraint.constant = keyboardHeight + 20
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
            loginPropertiesModel[loginPageCounter-1].firstTextFieldText = firstTextField.text ?? ""
            loginPropertiesModel[loginPageCounter-1].secondtTextFieldText = secondTextField.text ?? ""
            loadingIndicatorView.startAnimating()
            loginPageCounter += 1
            self.firstTextField.becomeFirstResponder()
        }
    }
    
    func checkTextFieldValid(textField: UITextField!)-> Bool {
        if let textField = textField {
            if(textField.text!.isEmpty &&
               textField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
                AlertBoxManager.shared.delegate = self
                AlertBoxManager.shared.showAlertBoxOK(title: "Hatalı Giriş", message: "Alanları yanlış girdiniz.")
                return false
            }
        }
        return true
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
