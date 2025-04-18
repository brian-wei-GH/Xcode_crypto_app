//
//  StatisticModel.swift
//  Crypto
//
//  Created by 黃騰威 on 4/16/25.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percenatageChange: Double?) {
        self.title = title
        self.value = value
        self.percentageChange = percenatageChange
    }
    
}


