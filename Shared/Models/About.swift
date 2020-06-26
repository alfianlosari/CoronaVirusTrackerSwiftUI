//
//  About.swift
//  CoronaVirusTracker
//
//  Created by Alfian Losari on 07/03/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

struct About {
    
    let title: String
    let copyrights: [Copyright]
    
    struct Copyright: Identifiable {
        let id = UUID()
        let title: String
        let license: String
    }
}

extension About {
    
    static var defaultAbout: About {
        About(title: "Made with ❤️. GitHub: alfianlosari\n\nhttps://alfianlosari.com | Xcoding With Alfian\n©2020 Alfian Losari. All Rights Reserved", copyrights: [
            .init(title: "Statistic & Map Copyright", license: """
            ArcGIS Corona Virus Datasets.
            https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query

            Esri Proprietary Rights Acknowledgment
            Copyright © 1995–2019 Esri.
            All rights reserved.
            Published in the United States of America.

            The information contained in this work is the exclusive property of Environmental Systems Research Institute, Inc. (Esri), and any respective copyright owners. This work is protected under United States copyright law and other international copyright treaties and conventions.

            Esri grants the recipient of the Esri information contained within the esri.com Web site the right to freely reproduce, redistribute, rebroadcast, and/or retransmit this information for personal, noncommercial purposes, including teaching, classroom use, scholarship, and/or research, subject to the fair use rights enumerated in sections 107 and 108 of the Copyright Act (Title 17 of the United States Code). All copies, whether in whole or in part, shall include the appropriate Esri copyright notice.

            No part of this work may be reproduced or transmitted for commercial purposes, in any form or by any means, electronic or mechanical, including photocopying and recording, or by any information storage or retrieval system, except as expressly permitted in writing by Esri. Requests by mail should be addressed to Director, Contracts and Legal Department, Esri, 380 New York Street, Redlands, California 92373-8100, USA.

            Questions or requests regarding permissions may be sent by e-mail.
            Digital Millennium Copyright Act Policy
            The information contained in the home page is subject to change without notice.
            """),
            .init(title: "Advice Copyright", license: "WHO (World Health Organization)\nhttps://www.who.int/emergencies/diseases/novel-coronavirus-2019")
        ])
    }
    
}
