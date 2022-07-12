//
//  Event.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 21.06.22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Event: Hashable, Codable, Identifiable {
    var title: String?
    var organisation: String?
    var date: String?
    var time: String?
    var address: String?
    var state: String?
    var id: Int?
    var isBookmarked: Bool
    var description: String?
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case events = "Events"
        case industryNews = "Industry News"
        case classes = "Classes"
        case jobOpportunities = "Job Opportunities"
    }
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable{
        var latitude: Double
        var longitude: Double
}
    
    
}
