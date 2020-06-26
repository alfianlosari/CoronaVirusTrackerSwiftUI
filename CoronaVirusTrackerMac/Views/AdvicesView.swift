//
//  AdvicesView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 25/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct AdvicesView: View {
    
    @ObservedObject var adviceObservable = WhoAdviceObservedObject()
    
    @State var selection: String?

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(adviceObservable.advice!.topics) { card in
                    NavigationLink(destination: TopicView(topic: card), tag: card.title, selection: $selection) {
                        Text(card.title)
                        .padding(.vertical)
                    }
                }
            }
            .background(Color(NSColor.controlBackgroundColor))
            .frame(minWidth: 240, maxWidth: 240)
            .edgesIgnoringSafeArea(.top)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct AdvicesView_Previews: PreviewProvider {
    static var previews: some View {
        AdvicesView()
    }
}
