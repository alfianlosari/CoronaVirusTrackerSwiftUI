//
//  AdviceView.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 05/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI


struct AdviceView: View {
    
    @ObservedObject var adviceObservable = WhoAdviceObservedObject()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if adviceObservable.advice != nil {
                    VStack(alignment: .leading, spacing: 32) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(adviceObservable.advice!.topics) { card in
                                NavigationLink(destination: TopicView(topic: card)) {
                                    HStack {
                                        Text(card.title)
                                        Spacer()
                                        Image(systemName: "chevron.right.circle")
                                    }
                                        
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.vertical)
                                    .background(Color(UIColor.systemBackground))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(adviceObservable.advice!.title)
                                .font(.title)
                            Text(adviceObservable.advice!.subtitle)
                                .font(.body)
                                .padding(.all)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(8)
                        }
                        
                        ForEach(adviceObservable.advice!.basics) { basic in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(basic.title)
                                    .font(.headline)
                                Text(basic.subtitle)
                                    .font(.body)
                                    .padding(.all)
                                    .background(Color(UIColor.systemBackground))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.all)
                }
            }
            .navigationBarTitle("WHO Advice", displayMode: .inline)
            .background(Color(UIColor.secondarySystemBackground))
        }
    }
}
