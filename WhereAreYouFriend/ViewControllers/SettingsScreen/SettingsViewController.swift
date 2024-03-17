//
//  SettingsViewController.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 29.01.2024.
//

import UIKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension SettingsViewController: UITableViewDelegate {
    
   
    
}


extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "ayar1"
        return cell
    }
}
