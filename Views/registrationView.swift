//
//  registrationView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 21.06.22.
//

import SwiftUI
import Firebase

struct registrationView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    @State var fullname: String = ""
    @State private var registrationEmail: String = ""
    @State private var registrationPassword: String = ""
    @State var givenOccupation: String = ""
    @State var givenCompany: String = ""
    @State private var userSignedUp: Bool = false

    var body: some View {
        if userSignedUp {
            profileView()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack{
            Color("GreyYellow")
            VStack{
                VStack{
                    Text("Sign up to Kobae.")
                        .font(.custom("Futura", size: 35.0))
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
                VStack(alignment: .leading){
                    Text("Full Name")
                            .font(.custom("Futura", size: 20.0))
                            .foregroundColor(Color("DarkPink"))
                    TextField("", text: $fullname)
                            .padding()
                            .background(.white)
                            .cornerRadius(5.0)
                    Text("Email")
                        .font(.custom("Futura", size: 20.0))
                        .foregroundColor(Color("DarkPink"))
                    TextField("", text: $registrationEmail)
                        .padding()
                        .background(.white)
                        .cornerRadius(5.0)
                    Text("Password")
                        .font(.custom("Futura", size: 20.0))
                        .foregroundColor(Color("DarkPink"))
                    SecureField("", text: $registrationPassword)
                        .padding()
                        .background(.white)
                        .cornerRadius(5.0)
                    Text("Occupation")
                            .font(.custom("Futura", size: 20.0))
                            .foregroundColor(Color("DarkPink"))
                    TextField("", text: $givenOccupation)
                            .padding()
                            .background(.white)
                            .cornerRadius(5.0)
                    Text("Company")
                            .font(.custom("Futura", size: 20.0))
                            .foregroundColor(Color("DarkPink"))
                    TextField("", text: $givenCompany)
                            .padding()
                            .background(.white)
                            .cornerRadius(5.0)
                    }
                .padding(.horizontal)
                .padding(.bottom, 20)
                VStack{
                    Button {
                            register()
                            storeUserInformation()
                        } label: {
                            Text("SIGN UP")
                                    .bold()
                                .frame(width: 220, height: 60)
                                .background(Color("DarkPink"))
                                .cornerRadius(15.0)
                                .foregroundColor(.white)
                        }
                    .padding(.horizontal)
                }
            }
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userSignedUp.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func register() {
        Auth.auth().createUser(withEmail: registrationEmail, password: registrationPassword) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
}
    
    func storeUserInformation() {
        guard let id = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["id": id, "fromID": self.fullname, "email": self.registrationEmail, "occupation": self.givenOccupation, "company": self.givenCompany]
        FirebaseManager.shared.firestore.collection("users")
            .document(id).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
            }
    }

}

struct registrationView_Previews: PreviewProvider {
    static var previews: some View {
        registrationView().environmentObject(ViewRouter())
    }
}
