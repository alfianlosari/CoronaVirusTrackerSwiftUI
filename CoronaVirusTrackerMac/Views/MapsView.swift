//
//  MapsView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import MapKit

struct MapsView: View {
    
    @EnvironmentObject var caseObservable: CoronaCaseObservedObject
    
    var body: some View {
        MapView(cases: $caseObservable.cases)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.top)
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
    }
}
