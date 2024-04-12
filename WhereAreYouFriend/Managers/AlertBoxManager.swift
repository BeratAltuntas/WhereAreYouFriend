//
//  AlertBoxManager.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 12.04.2024.
//

import UIKit

final class AlertBoxManager {
    
    static let shared: AlertBoxManager = AlertBoxManager(delegate: UIViewController.init())
    var delegate: UIViewController
    
    
    init(delegate: UIViewController) {
        self.delegate = delegate
    }
    
    func showAlertBoxOK(title: String, message: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.delegate.present(ac, animated: true)
        }
    }
    
}
