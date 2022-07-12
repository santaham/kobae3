//
//  homeView.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 20.06.22.
//

import SwiftUI

struct homeView: View {
    
    @State private var selection: Tab = .home

    enum Tab {
        case profile
        case home
        case network
        case messages
    }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
    ZStack(alignment: .top){
            
            Color(.white)
        
        TabView(selection: $selection) {
            profileView()
                .tabItem{
                Label("Profile", systemImage: "person.fill")
                }
                .tag(Tab.profile)
            CategoryHome(modelData: ModelData())
                //.offset(y: 100.0)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            networkContentView()
                .tabItem{
                    Label("Network", systemImage: "network")
                }
                .tag(Tab.network)
            messagesView()
                .tabItem{
                    Label("Messages", systemImage: "message.fill")
                }
                .tag(Tab.messages)
        }
        
        
        
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView().environmentObject(ModelData())
    }
}

}

struct CategoryHome: View {
    
    var modelData: ModelData
    
    var body: some View {
        VStack{
        homePageTopBanner()
        NavigationView{
            List{
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                    ForEach(modelData.categories.keys.sorted(), id: \.self) {key in CategoryRow(categoryName: key, items: modelData.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .navigationTitle("What's Up In...")
            }
        }
    }
}

struct homePageTopBanner: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Welcome back,")
                    .foregroundColor(.black)
                    .font(.custom("Futura", size: 20.0))
                Text("Mitchell")
                    .foregroundColor(.white)
                    .font(.custom("Futura", size: 50.0))
            }

            Spacer()
            
        }
        .padding()
        .background(Color("DarkPink"))
    }
}
