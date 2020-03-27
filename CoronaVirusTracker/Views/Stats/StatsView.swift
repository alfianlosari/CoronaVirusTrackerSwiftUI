//
//  StatsView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 06/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

struct StatsView: View {
    
    @State private var searchTerm : String = ""
    @State private var searchBarHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ScrollView {
                TotalCountContainerView()
                    .padding(.top)
                    .padding(.horizontal)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                SearchBar(text: $searchTerm, keyboardHeight: $searchBarHeight, placeholder: "Search for a country")
                    .padding(.horizontal).padding(.top)
                CoronaCaseTableView(searchTerm: $searchTerm)
                    .padding(.horizontal)
                    .padding(.bottom, searchBarHeight)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
            .background(Color(UIColor.secondarySystemBackground))
            .navigationBarTitle("Corona Virus Tracker", displayMode: .inline)
    
        }
    }
    
}

