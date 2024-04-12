//
//  LocationModel.swift
//  WhereAreYouFriend
//
//  Created by BERAT ALTUNTAŞ on 12.04.2024.
//

import Foundation
import MapKit

class BaseLocationModel : NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
