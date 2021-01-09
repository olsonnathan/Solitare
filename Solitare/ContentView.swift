//
//  ContentView.swift
//  Solitare
//
//  Created by Nathan Olson on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Press to Begin") {
            let solitare = Solitare()
            solitare.setup()
        }
    }
}

// TODO:
// tableau must alternate when stacking
// card needs a rectangle
// card needs to be draggable
// card needs to snap to tableau
// variable deck passes 1 / 3 / infinite
// variable turns 1 / 3
// disable 1 deck pass for 3 turns

class Solitare {
    var stock = [Card]()
    var waste = [Card]()
    var tableaus = [[Card]]()
    var foundations = [Card]()
    
    func setup() {
        foundations = []
        stock = []
        tableaus = []
        waste = []
        
        buildStock()
        //print(stock.count)
        buildTableaus()
        //print(tableaus)
    }
    
    func buildStock() {
        for rank in Card.Rank.allCases {
            for suit in Card.Suit.allCases {
                let card = Card(suit: suit,
                                rank: rank)
                print(card)
                stock.append(card)
            }
        }
    }
    
    func buildTableaus() {
        for tableau in 0...6 {
            var pile = [Card]()
            for _ in 0...tableau {
                let draw = Int.random(in: 0...(stock.count - 1))
                print(stock.count)
                pile.append(stock[draw])
                stock.remove(at: draw)
                
            }
            tableaus.append(pile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
