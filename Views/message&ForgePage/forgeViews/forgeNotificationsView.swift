//
//  forgeNotificationsView.swift
//  kobae
//
//  Created by sam on 02.07.22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class forgeNotificationsViewModel: ObservableObject {
    
    var ForgeUser: forgeUser?
    @Published var errorMessage = ""
    @Published var requestingUsers = [forgeRequest]()
    
    init() {
        getAllRequests()
    }
    
    var firestoreListener: ListenerRegistration?
    
    func getAllRequests() {
        guard let toID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let fromID = ForgeUser?.fromID else { return }
        firestoreListener = FirebaseManager.shared.firestore
            .collection("directRequests")
            .document(toID)
            .collection(fromID)
            .order(by: "timestamp")
            .addSnapshotListener { QuerySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for requests: \(error)"
                    print(error)
                    return
                }
                
                QuerySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
                            if let cm = try? change.document.data(as: forgeRequest.self) {
                                self.requestingUsers.append(cm)
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
    


struct forgeNotificationsView: View {
    @ObservedObject private var vm = forgeNotificationsViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    var ForgeUser: forgeUser?
    var body: some View {
        VStack {
           // HStack {
             //   Text("Requests")
               //     .font(.custom("Futura", size: 30.0))
                 //   .foregroundColor(.white)
                 //   .padding()
                //Spacer()
            //}
            //.background(Color("DarkPink"))
            ScrollView{
                List{
                ForEach(vm.requestingUsers){ requestingUser in
                    HStack{
                        Button{
                            viewRouter.currentPage = .page3
                        } label: {
                            HStack(spacing: 16) {
                                Image("person5")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipped()
                                    .cornerRadius(64)
                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                                .stroke(Color.black, lineWidth: 1))
                                    .shadow(radius: 5)
                                
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(requestingUser.requesterID)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(.label))
                                        .multilineTextAlignment(.leading)
                                    Text(requestingUser.requestMessage)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(.darkGray))
                                        .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                        }
                    }
                        
                }
            }
        }
    }
    
}


struct forgeNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        forgeNotificationsView()
    }
}
