//
//  TopicView.swift
//  CoronaVirusTrackerMac
//
//  Created by Alfian Losari on 26/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct TopicView: View {
    
    let topic: WHOTopic
    var body: some View  {
        
        List {
            VStack(alignment: .leading, spacing: 32) {
                ForEach(self.topic.questions) { question in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(question.title)
                                .font(.title2)
                            Text(question.subtitle)
                                .font(.body)
                        }
                    }
                }
            }
            .padding(.all)
        }
    }
}


struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView(topic: WHOTopic.init(title: "Test", questions: [WHOData(title: "", subtitle: "")]))
    }
}
