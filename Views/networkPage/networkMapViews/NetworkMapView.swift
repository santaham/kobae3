//
//  MapView.swift
//  kobae
//
//  Created by sam on 04.07.22.
//

import SwiftUI

struct NetworkMapView: View {
    @ObservedObject var selection: SelectionHandler
    @ObservedObject var mesh: Mesh
    var body: some View {
        ZStack {
        //Rectangle().fill(Color.white)
          EdgeMapView(edges: $mesh.links)
          NodeMapView(selection: selection, nodes: $mesh.nodes)
        }
    }
}

struct NetworkMapView_Previews: PreviewProvider {
    static var previews: some View {
        let mesh = Mesh()
        let child1 = Node(position: CGPoint(x: 100, y: 200), text: "child 1")
        let child2 = Node(position: CGPoint(x: -100, y: 200), text: "child 2")
        [child1, child2].forEach {
          mesh.addNode($0)
          mesh.connect(mesh.rootNode(), to: $0)
        }
        mesh.connect(child1, to: child2)
        let selection = SelectionHandler()
        return NetworkMapView(selection: selection, mesh: mesh)
    }
}
