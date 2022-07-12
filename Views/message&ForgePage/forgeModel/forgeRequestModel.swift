//
//  forgeRequestModel.swift
//  kobae
//
//  Created by sam on 02.07.22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct forgeRequest:Identifiable, Codable {
    
    @DocumentID var id: String?
    let requesterID, requesteeID: String
    let mutualID, requestMessage: String
    let connectionStatus, mutualActivated: Bool
    
}
