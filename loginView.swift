//
//  ContentView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 20.06.22.
//

import SwiftUI
import Firebase

//
//let storedEmail = "Myemail"
//let storedPassword = "Mypassword"

struct loginView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack{
            Color("GreyYellow")
            loginFields()
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            viewRouter.currentPage = .page2
                        }
                    }
                }
        }
        .ignoresSafeArea()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        loginView().environmentObject(ViewRouter())
    }
}
#endif
            
        
struct appNameWelcomePageline1: View {
    var body: some View {
        Text("Welcome back to").font(.custom("Futura", size: 20))
            .padding(.bottom, 10.0)
            .frame(height: 30.0)
    }
}

struct appImage: View {
    var body: some View{
        Image("logo")
            .clipShape(Circle())
            .shadow(radius: 5)
    }
}

struct appNameWelcomePageline2: View {
    var body: some View {
        Text("Kobae").font(.custom("Good Brush", size: 100))
            .foregroundColor(Color("Brown"))
            .padding(.bottom, 80.0)
            .frame(height: 70.0)
    }
}

struct loginEmailTextField: View {
    @Binding var loginEmail: String
    var body: some View {
        TextField("", text: $loginEmail)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding([.leading, .bottom, .trailing], 10.0)
    }
}

struct passwordSecureField: View {
    @Binding var password: String
    var body: some View {
        SecureField("", text: $password)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding([.leading, .bottom, .trailing],10)
    }
}

struct loginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(width: 220, height: 60)
            .background(.white)
            .cornerRadius(15.0)
    }
}

struct loginFields: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var loginEmail: String = ""
    @State var password: String = ""
    
    //@State var authenticationFailed: Bool = false
    //@State var authenticationSucceeded: Bool = false
    
    var body: some View {
        VStack{
            VStack{
                appNameWelcomePageline1()
                //appNameWelcomePageline2()
                appImage()
            }
            VStack(alignment: .leading){
            Text("Email")
                .font(.custom("Futura", size: 20.0))
                .padding()
            loginEmailTextField(loginEmail: $loginEmail)
                Text("Password").font(.custom("Futura", size: 20.0))
                    .padding()
            passwordSecureField(password: $password)

            }
            Button {
                login()
               // if self.loginEmail == storedEmail && self.password == storedPassword {
                 //   self.authenticationSucceeded = true
                   // self.authenticationFailed = false
                    //viewRouter.currentPage = .page2
                } //else {
                    //self.authenticationFailed = true
                //}
                //})
        label: {
                loginButtonContent()
            }
            .padding()
            .font(.custom("Futura", size: 20.0))
            
            VStack{
                Button(action: {viewRouter.currentPage = .page4}){
                    Text("Don't have an account yet? Sign up")
                        .font(.custom("Futura", size: 20.0))
                        .foregroundColor(.cyan)
                }
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: loginEmail, password: password){result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
