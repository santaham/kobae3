//
//  msgAndRequestsView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 28.06.22.
//

import SwiftUI
import SlidingTabView

//probably need suggestion rows at the bottom for when there are no existing chats yet

struct messagesView: View {
    @State private var tabIndex = 0
    
    var body: some View {
        VStack{
            HStack {
                Text("Messages")
                    .font(.custom("Futura", size: 30.0))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .background(Color("DarkPink"))
            SlidingTabView(selection: $tabIndex, tabs: ["Chats", "Requests"], font: .custom("Futura", fixedSize: 20.0), animation: .easeInOut, activeAccentColor: Color("DarkPink"), inactiveAccentColor: .black, selectionBarColor: Color("DarkPink"), inactiveTabColor: .white, activeTabColor: .white, selectionBarHeight: 3.0)
            Spacer()
            if tabIndex == 0 {
                existingChats()
            } else if tabIndex == 1 {
                forgeNotificationsView()
            }
            Spacer()
        }
    }
}

struct messagesView_Previews: PreviewProvider{
    static var previews: some View {
        messagesView()
    }
}
