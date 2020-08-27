//
//  TimelineEvent.swift
//  traveljournalios
//
//  Created by Sophia Xu on 12/6/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import Foundation

class TimelineEvent: Codable {
    var category: String!
    var activityName: String!
    var tripLocation: String!
    var date: String!
    var tripDescription: String!
    
    
    init(category: String, activityName: String, tripLocation: String, date: String, tripDescription: String) {
        self.category = category
        self.activityName = activityName
        self.tripLocation = tripLocation
        self.date = date
        self.tripDescription = tripDescription
    }
}
