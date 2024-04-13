//
//  ViewController.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 20.01.2024.
//

import UIKit
import MapKit
import CoreLocation

final class HomeViewController: BaseViewController {
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation = CLLocation.init(latitude: 0, longitude: 0)
    var yourCurrentLocation: BaseLocationModel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersCurrentLocation()
    }


}
extension HomeViewController: MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0]
        currentLocation = CLLocation.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        if yourCurrentLocation != nil{
            mapView.removeAnnotation(yourCurrentLocation)
        }
        // TODO: store users location
        yourCurrentLocation = BaseLocationModel(coordinate: currentLocation.coordinate)
        
        //mapView.addAnnotation(yourCurrentLocation)
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    func getUsersCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if(locationManager.authorizationStatus == .notDetermined ||
           locationManager.authorizationStatus == .denied ||
           locationManager.authorizationStatus == .restricted ||
           locationManager.authorizationStatus == .authorizedWhenInUse )
        {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
