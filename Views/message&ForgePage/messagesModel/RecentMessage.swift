//
//  RecentMessage.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 01.07.22.
//

import Foundation
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    @DocumentID var id: String?
    let text, email: String
    let fromid, toid: String
    let occupation: String
    let company: String
    let profileImageName: String
    let timestamp: Date
    let received: Bool
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
