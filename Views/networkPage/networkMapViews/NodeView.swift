//
//  NodeView.swift
//  kobae
//
//  Created by sam on 04.07.22.
//

import SwiftUI

struct NodeView: View {
    static let width = CGFloat (100)
    @State var node: Node
    @ObservedObject var selection: SelectionHandler
    
    var isSelected: Bool {
      return selection.isNodeSelected(node)
    }
    var body: some View {
        Ellipse()
          .fill(Color("DarkPink"))
          .overlay(Ellipse()
            .stroke(isSelected ? Color.red : Color.black, lineWidth: isSelected ? 5 : 3))
          .overlay(Text(node.text)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
          .foregroundColor(.white)
          .frame(width: NodeView.width, height: NodeView.width, alignment: .center)
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        let selection1 = SelectionHandler()
        let node1 = Node(text: "uhm")
        let selection2 = SelectionHandler()
        let node2 = Node(text: "perhaps")
        selection2.selectNode(node2)

        return VStack {
          NodeView(node: node1, selection: selection1)
          NodeView(node: node2, selection: selection2)
        }
    }
}
