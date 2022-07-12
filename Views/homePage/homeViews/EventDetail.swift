//
//  EventDetail.swift
//  kobaeSwiftUIVers
//
//  Created by sam on 21.06.22.
//

import SwiftUI

struct EventDetail: View {
    @EnvironmentObject var modelData: ModelData
    var event: Event

    var eventIndex: Int {
        modelData.events.firstIndex(where: { $0.id == event.id })!
    }

    var body: some View {
        ScrollView {
            ZStack {
                MapView(coordinate: event.locationCoordinate)
                   .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                Image("\(event.imageName)")
                    .padding(.bottom, -130)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(event.title!)
                        .font(.title)
                }

                HStack {
                    Text(event.address!)
                    Spacer()
                    Text(event.state!)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(event.title!)")
                    .font(.title2)
                Text(event.description!)
            }
            .padding()
        }
        .navigationTitle(event.title!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        EventDetail(event: modelData.events[0])
            .environmentObject(modelData)
    }
}
