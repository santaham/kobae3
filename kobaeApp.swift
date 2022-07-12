//
//  kobaeApp.swift
//  kobae
//
//  Created by sam on 02.07.22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true
  }
}

@main
struct kobaeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            motherView().environmentObject(viewRouter)
        }
    }
}
