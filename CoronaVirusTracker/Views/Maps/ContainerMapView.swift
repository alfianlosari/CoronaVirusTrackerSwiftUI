//
//  ContainerMapView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 05/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContainerMapView: View {
    
    @EnvironmentObject var caseObservable: CoronaCaseObservedObject

    var body: some View {
        MapView(cases: $caseObservable.cases)
    }
}

struct ContainerMapView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerMapView()
    }
}
