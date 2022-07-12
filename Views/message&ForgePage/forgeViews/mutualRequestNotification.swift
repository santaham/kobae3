//
//  cardView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 22.06.22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class mutualNotifViewModel: ObservableObject {

    @Published var errorMessage = ""
    
    @Published var requestMessage = [forgeRequest]()
    
    var ForgeUser: forgeUser?
    
    init(ForgeUser: forgeUser?) {
        self.ForgeUser = ForgeUser
    
        fetchRequestMessage()
    }
    
    var firestoreListener: ListenerRegistration?
    
    func fetchRequestMessage() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = ForgeUser?.toID else { return }
        firestoreListener = FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }
            
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
                            if let cm = try? change.document.data(as: forgeRequest.self) {
                                self.requestMessage.append(cm)
                                print("Appending chatMessage in ChatLogView: \(Date())")
                            }
                        } catch {
                            print("Failed to decode message: \(error)")
                        }
                    }
                })
                }
            }
    }

struct mutualRequestNotification: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var translation: CGSize = .zero
    @ObservedObject var vm: mutualNotifViewModel
    private var user: forgeUser
    private var onRemove: (_ user: forgeUser) -> Void
    
    init(user: forgeUser, onRemove: @escaping (_ user: forgeUser) -> Void) {
            self.user = user
            self.onRemove = onRemove
            self.vm = .init(ForgeUser: user)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            //ZStack {
                VStack(alignment: .center){
                    forgeRequestBanner()
                    forgeRequester(user: forgeUser(id: vm.ForgeUser!.id, email: "hello@gmail.com", occupation: "Management Consultant", company: "McKinsey", mutualConnections: 30, imageName: "person1", fromID: "Charles Miller", toID: "NIL"))
                    Divider()
                    HStack{
                        firstMutual()
                        secondMutual()
                    }
                    .frame(width: geometry.size.width, height: 100.0)
                    Divider()
                    ForEach(vm.requestMessage) { message in
                        requestMessageView(message: message)
                    }
                    Divider()
                    HStack{
                        Button(action: {viewRouter.currentPage = .page5}){
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                        }
                        Spacer()
                        Button(action: {viewRouter.currentPage = .page6}){
                            Image(systemName: "plus.message")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                        }
                        Spacer()
                        Button(action: {viewRouter.currentPage = .page5}){
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 80.0, height: 80.0)
                        }
                    }
                }
        }
    }
}

struct forgeRequestBanner: View {
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(Color("DarkPink"))
            }
            HStack(alignment: .center){
                Text("Forge Requests")
                    .font(.custom("Futura", size: 30.0))
            }
        }
    }
}

struct forgeMutualRequestView_Previews: PreviewProvider {
    static var previews: some View {
        mutualRequestNotification(user: forgeUser(id: "2001", email: "123@gmail.com", occupation: "Doctor", company: "SGH", mutualConnections: 30, imageName: "person1", fromID: "Oliver Jones", toID: "Charles Miller"),
                         onRemove: { _ in
                            // do nothing
                    }).frame(height: 700.0).padding().previewInterfaceOrientation(.portrait)
    }
}

struct forgeRequester: View {
    
    var user: forgeUser
    
    var body: some View {
                VStack(alignment: .center){
                    Image("person1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100.0)
                        .clipShape(Circle())

                        VStack(alignment: .center, spacing: 6){
                            Text("\(user.fromID)")
                                .font(.custom("Futura", size: 30.0))
                            Text("\(user.occupation)")
                                .font(.custom("Futura", size: 25.0))
                            Text("\(user.company)")
                                .font(.custom("Futura", size: 20.0))
                            Text("\(user.mutualConnections) Mutual Connections")
                        }.padding(.horizontal)
                }
    }
}

struct firstMutual: View {
    var body: some View {
        GeometryReader { geometry in
        VStack(alignment: .center){
            Image("person2")
                .resizable()
                .scaledToFill()
                .frame(height: geometry.size.height)
                .clipShape(Circle())
            }
        }
    }
}

struct secondMutual: View {
    var body: some View {
        GeometryReader { geometry in
        VStack(alignment: .center){
            Image("person3")
                .resizable()
                .scaledToFill()
                .frame(height: geometry.size.height)
                .clipShape(Circle())
            }
        }
    }
}

struct requestMessageView: View {
    let message: forgeRequest
    
    var body: some View {
        VStack {
            if message.requesterID == FirebaseManager.shared.auth.currentUser?.uid {
                    HStack {
                        Text(message.requestMessage)
                            .foregroundColor(.white)
                            .font(.custom("Futura", size: 20.0))
                            .multilineTextAlignment(.center)
                    }
                }
        }
    }
}
