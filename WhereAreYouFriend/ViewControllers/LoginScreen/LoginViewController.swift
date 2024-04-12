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
                firstTextField.textContentType = .name
                secondTextField.textContentType = .username
                firstTextField.keyboardType = .default
                secondTextField.keyboardType = .default
                headerTitleText = "Login"
                break
            case 2:
                if loginPropertiesModel.count < 2 {
                    loginPropertiesModel.append(LoginScreenPropertiesModel(firstTextFieldTitle: "Email", firstTextFieldPlaceHolder: "Your Email", secondtTextFieldTitle: "Password", secondTextFieldPlaceHolder: "Your Password", pageNumber: loginPageCounter))
                }
                firstTextField.textContentType = .emailAddress
                firstTextField.keyboardType = .emailAddress
                
                secondTextField.textContentType = .password
                secondTextField.keyboardType = .alphabet
                
                headerTitleText = "Login"
                break
            case 3:
                
                if loginPropertiesModel.count < 3 {
                    loginPropertiesModel.append(LoginScreenPropertiesModel(firstTextFieldTitle: "Phone Number", firstTextFieldPlaceHolder: "Your Phone Number", secondtTextFieldTitle: "Password", secondTextFieldPlaceHolder: "Your Password", pageNumber: loginPageCounter))
                }
                firstTextField.textContentType = .telephoneNumber
                firstTextField.keyboardType = .phonePad
                headerTitleText = "Login"
                break
            case 4:
                if loginPropertiesModel.count < 4 {
                    loginPropertiesModel.append(LoginScreenPropertiesModel(firstTextFieldTitle: "Verification Code", firstTextFieldPlaceHolder: "Your Verification Code", secondtTextFieldTitle: "Password", secondTextFieldPlaceHolder: "Your Password", pageNumber: loginPageCounter))
                }
                firstTextField.textContentType = .oneTimeCode
                firstTextField.keyboardType = .numberPad
                headerTitleText = "Login"
                break
            default:
                headerTitleText = ""
                break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(loginPageCounter) - 1.0)) {[weak self] in
                self?.headerTitleLabel.text = headerTitleText
                self?.pageCounterLabel.text = "\(self!.loginPropertiesModel[self!.loginPageCounter-1].pageNumber) of 4"
                
                self?.firstTextLabel.text = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldTitle
                self?.firstTextField.placeholder = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldPlaceHolder
                self?.firstTextField.text = self?.loginPropertiesModel[self!.loginPageCounter-1].firstTextFieldText
                self?.secondTextField.isHidden = true
                self?.secondTextLabel.isHidden = true
                
                if(self!.loginPropertiesModel[self!.loginPageCounter-1].pageNumber < 3) {
                    self?.secondTextField.isHidden = false
                    self?.secondTextLabel.isHidden = false
                    self?.secondTextLabel.text = self?.loginPropertiesModel[self!.loginPageCounter-1].secondtTextFieldTitle
                    self?.secondTextField.placeholder = self?.loginPropertiesModel[self!.loginPageCounter-1].secondTextFieldPlaceHolder
                    self?.secondTextField.text = self?.loginPropertiesModel[self!.loginPageCounter-1].secondtTextFieldText
                }
               
                self?.loadingIndicatorView.stopAnimating()
                self?.loadingIndicatorView.isHidden = true
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
    
    @IBAction func primaryButton(_ sender: Any) {
        if let textField = sender as? UITextField {
            if textField.tag ==  1 {
                /// first textfield alanı
                self.firstTextField.resignFirstResponder()
                
                if !self.secondTextField.isHidden {
                    self.secondTextField.becomeFirstResponder()
                }
                
            } else if textField.tag == 2 {
                /// second  textfield alanı
                self.secondTextField.resignFirstResponder()
                textField.endEditing(true)
                
                ContinueButton_TUI(self)
            }
        }
    }
    
    @IBAction func ContinueButton_TUI(_ sender: Any) {
        if(checkTextFieldValid(textField: firstTextField) && checkTextFieldValid(textField: secondTextField)) {
            
            loadingIndicatorView.startAnimating()
            loginPropertiesModel[loginPageCounter-1].firstTextFieldText = firstTextField.text ?? ""
            loginPropertiesModel[loginPageCounter-1].secondtTextFieldText = secondTextField.text ?? ""
            
            loginPageCounter += 1
            
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
