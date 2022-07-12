//
//  networkView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 20.06.22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class mutualRequestViewModel: ObservableObject {
    @Published var requestMessage = ""
    
    @Published var request = [forgeRequest]()
    
    @Published var errorMessage = ""
    
    var ForgeUser: forgeUser?
    
    init(ForgeUser: forgeUser?){
        self.ForgeUser = ForgeUser
    }
    
    var firestoreListener: ListenerRegistration?
    
    func sendRequest() {
        guard let requesterID =
            FirebaseManager.shared.auth.currentUser?.uid else { return }
                
        guard let requesteeID = ForgeUser?.toID else { return }

        //insert declaration to store the ID of the person that is being requested

        
        let document = FirebaseManager.shared.firestore.collection("directRequests")
            .document(requesterID)
                .collection(requesteeID).document()
        
        let requestInstance = ["requesterID": requesterID, "requesteeID": requesteeID, "mutualID": "", "requestMessage": self.requestMessage, "connectionStatus": false, "mutualActivated": true] as [String:Any]
        
        try? document.setData(requestInstance) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
    }
        
        let mutualDocument = FirebaseManager.shared.firestore.collection("directRequests")
            .document(requesteeID)
                .collection(requesterID).document()
        
        try? mutualDocument.setData(requestInstance) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
        }
        
        //let requesteeDocument = FirebaseManager.shared.firestore.collection("directRequests")
          //  .document(mutualID)
            //.collection(fromID).document()
            //.collection(toID).document()
        
       // try? requesteeDocument.setData(requestInstance) { error in
         //   if let error = error {
           //     print(error)
             //   self.errorMessage = "Failed to save message into Firestore: \(error)"
               // return
            //}
        //}
        
        self.requestMessage = ""
}

}


struct networkContentView: View {
    @State var searchQuery = ""
    var NetworkConnectionModel = networkConnectionModel()
    
    var body: some View {
        SurfaceView(mesh: Mesh.sampleMesh(), selection: SelectionHandler())
        //GeometryReader { geometry in
    //ZStack {
      //  VStack {
        //    networkPageBanner()
          //  NavigationView{
            //    requesteeListView(
              //      searchQuery: $searchQuery)
                
                //requesteeDetailView(user2: networkConnectionModel().requestees[0])
            //}
            //.searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            //.frame(width: geometry.size.width, height: geometry.size.height * 0.4)
        //}
        //}
        //}
    }
}
    

struct networkView_Previews: PreviewProvider {
    static var previews: some View {
        networkContentView()
    }
}

struct networkPageBanner: View {
    var body: some View {
        VStack {
            HStack{
                Text("Your Network")
                    .font(.custom("Futura", size: 30.0))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Spacer()
            }
            HStack{
                Text("Find more people to connect with now!")
                    .font(.custom("Futura", size: 15.0))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct requesteeListView: View {
    @Environment(\.isSearching) var isSearching
    @Binding var searchQuery: String
    //@Binding var isSearchingOccupation: Bool
    
    var NetworkConnectionModel = networkConnectionModel()
    var filteredRequestees: [forgeUser] {
        if searchQuery.isEmpty {
            return NetworkConnectionModel.requestees
        } else {
            return NetworkConnectionModel.requestees.filter {
                $0.fromID
                    .localizedStandardContains(searchQuery)
            }
        }
    }
    
    var body: some View {
                List {
                    ForEach(filteredRequestees, id: \.self) { user2 in
                    NavigationLink(destination: requesteeDetailView(user2: user2)) {
                        HStack {
                            Image("\(user2.imageName)")
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                                .clipShape(Circle())
                            Text(user2.fromID)
                                .foregroundColor(.black)
                        }
                    }
                    .listStyle(.inset)
                    .padding()
                    }
                }
    }
    
    //firestore data converter – into custom data type forgeUser
    
    
}

   // struct requesteeListView_Previews: PreviewProvider {
        //static var previews: some View {
          //  requesteeListView(searchQuery: .constant(""))
        //}
    //}
        
    struct requesteeDetailView: View {
        var user2: forgeUser
        var MutualRequestViewModel = mutualRequestViewModel(ForgeUser: nil)
        @State var directRequestMessage: String = ""

        var body: some View {
            //ScrollView {
            ScrollView{
                VStack{
                    HStack{
                        Image("\(user2.imageName)")
                            .resizable()
                            .frame(width: 150.0, height: 150.0)
                            .clipShape(Circle())
                        VStack {
                            Text("\(user2.fromID)")
                                .font(.custom("Futura", size: 30.0))
                            Text("\(user2.occupation)")
                            Text("\(user2.company)")
                            Text("\(user2.mutualConnections) connections")
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Request a Direct Connection")
                            .font(.custom("Futura", size: 20.0))
                            .foregroundColor(Color("DarkPink"))
                        TextField("Let them know who you are!", text: $directRequestMessage)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(5.0)
                            .padding(.horizontal)
                        HStack(alignment: .center){
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Connect me!")
                                    .font(.custom("Futura", size: 20))
                        }
                            .padding(.horizontal)
                            .padding(.vertical, 5.0)
                            .foregroundColor(.white)
                            .background(Color("DarkPink"))
                            .cornerRadius(15.0)
                            Spacer()
                        }
                    }
                        .padding()
                    Text("Mutuals to Connect With...")
                        .font(.custom("Futura", size: 20.0))
                        .foregroundColor(Color("DarkPink"))
                        .padding(.horizontal)
                    mutualListView()
                        //NavigationView{
                           
                    //.navigationBarTitle("")
                        //.navigationBarHidden(true)
                            //mutualRequestView(vm: MutualRequestViewModel, mutual: forgeUser(id: "2003", email: "123@gmail.com", occupation: "Doctor", company: "SGH", mutualConnections: 30, imageName: "person1", fromID: "Oliver Jones", toID: "Charles Miller"))
                        //}
                    //}
                }
            }
        }
    }

   // struct requesteeDetailView_Previews: PreviewProvider {
        //static var previews: some View {
          //  requesteeDetailView(user2: networkConnectionModel().requestees[0])
        //}
    //}
            
    struct mutualListView: View {
        var mutualList: [forgeUser] = load("forgeUserData.json")
                
        var mutualUser: forgeUser?
                
        //@State var showingPopup = false
        @EnvironmentObject var viewRouter: ViewRouter
                
                var body: some View {
                    NavigationView{
                    VStack(alignment: .leading){
                        List {
                          ForEach(mutualList, id: \.self) { mutual in
                              NavigationLink(destination: mutualRequestView(vm: .init(ForgeUser: mutualUser), mutual: mutual)) {
                                  VStack(alignment: .leading){
                                    //Button(mutual.fromID, action: {viewRouter.currentPage = .page7})
                                    Text(mutual.fromID)
                                        .foregroundColor(.black)
                                        .font(.custom("Futura", size: 15.0))
                                    Text("\(mutual.mutualConnections) Connections")
                                        .font(.custom("Futura", size: 15.0))
                                  }
                                  .padding()
                              }
                            }
                            }
                            .listStyle(.plain)
                        }
                    }
                    .frame(width: 400.0, height: 800.0)
                }
            }

    struct requestForgeUsers: View {
            var body: some View {
                VStack(alignment: .center){
                    Image(systemName: "flame.fill")
                        .resizable()
                    .frame(width: 40.0, height: 50.0)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(Color("DarkPink"))
                    Text("REQUEST A FORGE!")
                        .foregroundColor(Color("DarkPink"))
                        .font(.custom("Futura", size: 20.0))
                    HStack{
                        ZStack {
                            Image("person8")
                                .resizable()
                                .frame(width: 140.0, height: 140.0)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                .offset(x: -60.0)
                            Image("person9")
                                .resizable()
                                .frame(width: 140.0, height: 140.0)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                .offset(x: 60.0)
                        }
                    }
                }
                .frame(width: 300.0, height: 250.0)
            }
        }
