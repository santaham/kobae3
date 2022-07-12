//
//  Message.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 28.06.22.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Hashable, Identifiable, Codable {
    @DocumentID var id: String?
    var fromid: String
    var toid: String
    var text: String
    var received: Bool
    var timestamp: Date
}
