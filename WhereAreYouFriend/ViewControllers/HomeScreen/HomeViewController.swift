//
//  ViewController.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 20.01.2024.
//

import UIKit
import MapKit

final class HomeViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
extension HomeViewController: MKMapViewDelegate {
    
}
