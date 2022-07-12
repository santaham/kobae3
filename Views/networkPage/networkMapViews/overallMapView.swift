//
//  networkMapView.swift
//  kobae
//
//  Created by sam on 04.07.22.
//

import SwiftUI

struct overallMapView: View {
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

struct networkMapView_Previews: PreviewProvider {
    static var previews: some View {
        overallMapView()
    }
}
