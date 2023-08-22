//
//  data.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
    let type: String
    let image: String
    let time: Int
    let user: String
}
