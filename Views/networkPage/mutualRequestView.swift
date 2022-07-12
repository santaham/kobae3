//
//  mutualRequestView2.swift
//  kobae
//
//  Created by sam on 05.07.22.
//

import SwiftUI

struct mutualRequestView: View {
    @ObservedObject var vm: mutualRequestViewModel
    @Environment(\.presentationMode) var presentation
    var mutual: forgeUser
    @Environment(\.presentationMode) var presentationMode
            
            var body: some View {
                GeometryReader { geometry in
                ZStack{
                    Color("GreyYellow").ignoresSafeArea()
                    VStack{
                    VStack(alignment: .center){
                        requestForgeUsers()
                        HStack{
                            TextField(
                            "Send them a message!",
                            text: $vm.requestMessage)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(5.0)
                            .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width, height: 100.0)
                        HStack{
                            Spacer()
                            Button{
                                vm.sendRequest()
                                self.presentation.wrappedValue.dismiss()
                                
                            } label: {
                                Text("Form a Mutual!")
                            }
                            Spacer()
                            }
                        VStack(alignment: .leading){
                            Button{
                                presentationMode.wrappedValue.dismiss()
                            } label:{
                                Text("Back")
                            }
                            
                            }
                        }
                    }
                }
            }
        }
}

struct mutualRequestView_Previews: PreviewProvider {
    static var previews: some View {
        mutualRequestView(vm: .init(ForgeUser: nil), mutual: forgeUser(id: "2003", email: "123@gmail.com", occupation: "Doctor", company: "SGH", mutualConnections: 30, imageName: "person1", fromID: "Oliver Jones", toID: "Charles Miller") )
    }
}
