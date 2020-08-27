//
//  Trip.swift
//  traveljournalios
//
//  Created by Sophia Xu on 11/20/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import Foundation
import UIKit

// TO BE EDITED: Each trip has a name ("City, State (if Applicable), Country"), date, etc.
// Problem: how would users add images of their own? would storing its name even work if the file itself isn't on xcode
class Trip: Codable {
    

    var tripName: String
    var tripStartDate: String
    var tripEndDate: String
    var tripLocation: String
//    var imageName: String
    var imageData: Data?
    var tripDescription: String
    var timelineEvents: [TimelineEvent]
    // description, start date, end date


    init(tripName: String, tripStartDate: String, tripEndDate: String, tripLocation: String, imageData: Data, tripDescription: String, timelineEvents: [TimelineEvent]){

        self.tripName = tripName
        self.tripStartDate = tripStartDate
        self.tripEndDate = tripEndDate
        self.tripLocation = tripLocation

        self.imageData = imageData
        self.tripDescription = tripDescription
        self.timelineEvents = timelineEvents
    }
}

struct TripsDataResponse: Codable {
    var trips: [Trip]
}

struct TripsResponse: Codable {
    var data: TripsDataResponse
}

