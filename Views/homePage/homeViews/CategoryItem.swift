//
//  CategoryItem.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 21.06.22.
//

import SwiftUI

struct CategoryItem: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
                    event.image
                        .resizable()
                        .frame(width: 155, height: 155)
                        .cornerRadius(5)
            Text(event.title!)
                        .font(.caption)
                        //.multilineTextAlignment(.leading)
                        //.fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(event: ModelData().events[0])
    }
}
