//
//  AverageForgeUser.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 22.06.22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct forgeUser: Hashable, CustomStringConvertible, Codable, Identifiable {
    
    var id: String
    //let uid: String
    var email: String
    var occupation: String
    var company: String
    var mutualConnections: Int
    var imageName: String
    var fromID: String
    var toID: String
   
    var description: String{
        return "\(fromID), id: \(id)"
    }
    
}
