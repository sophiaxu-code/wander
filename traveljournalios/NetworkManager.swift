//
//  NetworkManager.swift
//  traveljournalios
//
//  Created by Sophia Xu on 11/20/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import Foundation
import Alamofire

// We had a problem integrating with backend. Backend required a user_id to be entered, which was different from the way IOS implemented our code. But assuming backend was the same, below would've been the code we would've used. Anywhere in our code where we created Trip objects or TimelineEvent objects, we woud've called addTrip or addEvent, respectively. 
let getTripEndpoint = "http://35.243.182.74/api/user/<int:user_id>/trips/"
let addTripEndpoint = "http://35.243.182.74/api/user/<int:user_id>/trips/"
let createEventEndpoint = "http://35.243.182.74/api/user/<int:user_id>/trip/<int:trip_id>/events/"


// How do we make network calls?
class NetworkManager {
    static func getTrips(completion: @escaping ([Trip]) -> Void) {
    Alamofire.request(getTripEndpoint , method: .get).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            
            if let tripsData = try? jsonDecoder.decode(TripsResponse.self, from: data) {
                let trips = tripsData.data.trips
                completion(trips)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
       
        }
        }
        
    }
    static func addTrip(trip: Trip){

    let parameters = [
        "title" : trip.tripName,
        "picture_link" : trip.imageData,
        "start_date" : trip.tripStartDate,
        "end_date" : trip.tripEndDate,
        "location" : trip.tripLocation,
        "description" : trip.tripDescription
        ] as [String : Any]
    Alamofire.request(addTripEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
        switch response.result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()

            if let tripData = try? jsonDecoder.decode(TripsResponse.self, from: data) {
                print(tripData.data.trips)
            }

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    }
    static func createEvent(timelineevent: TimelineEvent){
        let parameters = [
               "name" : timelineevent.activityName,
               "date" : timelineevent.date,
               "location" : timelineevent.tripLocation,
               "description" : timelineevent.tripDescription,
               "categories" : timelineevent.category
               ] 
           Alamofire.request(createEventEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
               switch response.result {
               case .success(let data):
                   let jsonDecoder = JSONDecoder()

                   if let tripData = try? jsonDecoder.decode(TripsResponse.self, from: data) {
                       print(tripData.data.trips)
                   }

               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
        
        }
    
}

