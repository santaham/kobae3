//
//  Categoryrow.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 21.06.22.
//

import SwiftUI

struct CategoryRow: View {
    
    var categoryName: String
    var items: [Event]
    
    var body: some View {
        VStack(alignment: .leading) {
                    Text(categoryName)
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    
            ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(items) { event in
                            NavigationLink { EventDetail(event: event)
                            } label: {
                            CategoryItem(event: event)
                                }
                            }
                        }
                    }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    
    static var events = ModelData().events
    
    static var previews: some View {
        CategoryRow(categoryName: events[0].category.rawValue,
                    items: Array(events.prefix(4)))
    }
}

