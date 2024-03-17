//
//  UserViewController.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 29.01.2024.
//

import UIKit

class UserViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        let isuserLogedIn : Bool = false
        
        if (!isuserLogedIn) {
            performSegue(withIdentifier: "goToLoginStoryboard", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoginStoryboard" {
            guard let vc = segue.destination as? LoginViewController else { return }
            vc.denee = ""
        }
    }
}
