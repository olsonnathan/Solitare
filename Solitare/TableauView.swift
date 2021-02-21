//
//  TableauView.swift
//  Solitare
//
//  Created by Nathan Olson on 2/20/21.
//

import SwiftUI

struct TableauView: View {
    let stack: [Card]
    @ObservedObject var viewState = ViewState()
    
    init(stack: [Card]) {
        self.stack = stack
    }
    
    var body: some View {
        makeCardStack()
    }
    
    func makeCardStack() -> AnyView {
        // TODO: build card stacks
        switch viewState.orientation {
        case .landscapeLeft, .landscapeRight:
            return AnyView(Text(""))
        default:
            // Portrait case
            return AnyView(Text(""))
        }
    }
}
