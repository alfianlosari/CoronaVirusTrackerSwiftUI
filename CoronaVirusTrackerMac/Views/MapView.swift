//
//  MapView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 26/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//


import SwiftUI

import MapKit

class CoronaCaseAnnotation: NSObject, MKAnnotation {
    
     let title: String?
     let coordinate: CLLocationCoordinate2D
     
     init(title: String?, coordinate: CLLocationCoordinate2D) {
       self.title = title
       self.coordinate = coordinate
     }
}

struct MapView: NSViewRepresentable {
    
    @Binding var cases: [CoronaCountryCase]?

    func makeNSView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context) {
        guard let countryCases = cases else {
            return
        }
        let cases = countryCases.map { $0.cases }.flatMap { $0 }.map { CoronaCaseAnnotation(title: "\($0.state ?? $0.country ?? "n/a") C\($0.confirmedText) D\($0.deathText) R \($0.recoveredText)", coordinate: CLLocationCoordinate2D(latitude: $0.latitude ?? 0, longitude: $0.longitude ?? 0))}
        nsView.annotations.forEach { nsView.removeAnnotation($0) }
        nsView.addAnnotations(cases)
    }
}
