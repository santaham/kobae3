//
//  profileView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 20.06.22.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class profileViewModel: ObservableObject {
    
    @Published var kobaeUser: forgeUser?
    @Published var errorMessage = ""
    
    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            self.kobaeUser = try? snapshot?.data(as: forgeUser.self)
            FirebaseManager.shared.currentUser = self.kobaeUser
        }
    }
}

struct profileView: View {
    
    @ObservedObject private var vm = profileViewModel()
    @State private var displayedName = ""
    @State private var displayedCompany = ""
    @State private var displayedEmail = ""
    @State private var displayedOccupation = ""
    
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15){
                    GeometryReader{proxy -> AnyView in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        
                        return AnyView(
                            ZStack{
                                HStack{
                                    Spacer()
                                    Text("insert custom banner")
                                    Spacer()
                                }
                                BlurView()
                                    .opacity(blurViewOpacity())
                            }
                                .frame(height: minY > 0 ? 180 + minY: 180)
                                .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                                .background(Color("GreyYellow"))
                        )
                    }
                    .frame(height: 180)
                    .zIndex(1)
                    VStack(alignment: .leading) {
                        
                        //NavigationView {
                            HStack{
                                Image("person7")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .padding(8)
                                    //.background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: offset < 0 ? getOffSet() - 20 : -20)
                                    .scaleEffect(getScale())

                                Spacer()
                                Button(action: { }) {
                                    Text("Edit Profile")
                                            .foregroundColor(Color("GreyGreen"))
                                            .padding(.vertical, 10)
                                            .padding(.horizontal)
                                            .background(
                                            Capsule()
                                                .stroke(Color("GreyGreen"))
                                            )
                                    }
                            .padding(.top, -25)
                        }
                            
                            //profile Data
                        VStack(alignment: .leading, spacing: 10){
                            TextField("Mitchell", text: $displayedName)//vm.kobaeUser?.fromID ?? "")
                                .font(.custom("Futura", size: 30.0))
                                    .foregroundColor(.white)
                            TextField("123@gmail.com", text: $displayedEmail)//vm.kobaeUser?.email ?? "")
                                    .foregroundColor(.white)
                                //query info from user database
                            let udOccupation = "Student" //vm.kobaeUser?.occupation ?? ""
                            let udWorkplace = "Yale-NUS" //vm.kobaeUser?.company ?? ""
                            Text("A \(udOccupation) at \(udWorkplace).")
                                .foregroundColor(.white)
                            }
                        // segmented menu – intro video goes here?
                    }
                    .padding(.horizontal)
                    .zIndex(-offset > 80 ? 0: 1)
                }
                
            })
            .background(Color("DarkPink"))
            .ignoresSafeArea(.all, edges: .top)
        }
    }
    
    func getOffSet() -> CGFloat{
        let progress = (-offset/80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale() -> CGFloat{
        let progress = -offset/80
        let scale = 1.8 - (progress < 1.0 ? progress: 1 )
        return scale < 11 ? scale: 1
    }
    
    func blurViewOpacity()-> Double{
        let progress = -(offset + 80)/150
        return Double(-offset > 0 ? progress : 0)
    }
    
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}


extension View{
    func getRect()-> CGRect{
        return UIScreen.main.bounds
    }
}
