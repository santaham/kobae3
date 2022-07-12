//
//  forgeUserModel.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 28.06.22.
//

import Foundation
import FirebaseFirestoreSwift

struct forgeUserModel: Codable, Hashable {
    var ForgeUser: [forgeUser] = load("forgeUserData.json")
}

