//
//  motherView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 20.06.22.
//

import SwiftUI

struct motherView: View {

    @EnvironmentObject var viewRouter: ViewRouter
    var MutualRequestViewModel = mutualRequestViewModel(ForgeUser: nil)
    var body: some View {
        switch viewRouter.currentPage {
            case .page1:
            loginView()
            case .page2:
            homeView()
            case .page3:
            directRequestNotification()
            case .page4:
            registrationView()
            case .page5:
            messagesView()
            case .page6:
            ChatLogView(vm: ChatLogViewModel(chatUser: nil))
            case .page7:
            mutualRequestView(vm: MutualRequestViewModel, mutual: forgeUser(id: "2003", email: "123@gmail.com", occupation: "Doctor", company: "SGH", mutualConnections: 30, imageName: "person1", fromID: "Oliver Jones", toID: "Charles Miller"))
            
        }
    }
}

struct motherView_Previews: PreviewProvider {
    static var previews: some View {
        motherView().environmentObject(ViewRouter())
    }
}
