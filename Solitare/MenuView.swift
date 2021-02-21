//
//  MenuView.swift
//  Solitare
//
//  Created by Nathan Olson on 1/8/21.
//

import SwiftUI

struct MenuView: View {
    init() { UITableView.appearance().backgroundColor = .clear }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: GameView()) {
                    Text("Play")
                }
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                }
            }.navigationTitle("Solitare")
        }
    }
}

struct GameView: View {
    // TODO: integrate solitare class
    @State var orientation = UIDevice.current.orientation
    @State var showingAlert = false
    @Environment(\.presentationMode) var presentation
    
    init() { UITableView.appearance().backgroundColor = .clear }
    
    // TODO: orientation publisher not working, card size not updating
    // https://stackoverflow.com/a/62370919/14030916
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    
    var body: some View {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.height
        
        let gridSize: CGFloat = 7
        let gridHeight: CGFloat = screenHeight / gridSize
        let gridWidth: CGFloat = screenWidth / gridSize
        
        let cardRatio: CGFloat = 1.4
        let cardRatioReciprocal: CGFloat = 1 / cardRatio
        
        let cardHeight: CGFloat = orientation.isLandscape ?
            gridWidth * cardRatio : //land
            gridHeight // port
        let cardWidth = orientation.isLandscape ?
            gridWidth : // land
            gridHeight * cardRatioReciprocal // port
        
        ZStack {
            // https://bit.ly/3iLABs2
            Rectangle()
                .fill(Color.white)
                .frame(width: cardWidth, height: cardHeight)
                .border(Color.black, width: 1)
            HStack {
                Text("A[")
                    .font(Font.custom("CardCharacters",
                                      size: 20))
                    .foregroundColor(.red)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .drawingGroup()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            trailing: Button(action: { self.showingAlert = true },
                             label: { Image("Heart") }) // TODO: Replace with pause icon
        ).actionSheet(isPresented: $showingAlert, content: {
                        ActionSheet(title: Text("Pause"),
                                    message: nil,
                                    buttons:
                                        [.cancel(),
                                         .default(Text("Save"),
                                                  action: { print("TODO") }),
                                         .destructive(Text("Quit"),
                                                      action: { self.presentation.wrappedValue.dismiss()
                                                      }
                                         )]
                        )}
        )
    }
}


// TODO:
// tableau must alternate when stacking
// card needs a rectangle
// card needs to be draggable
// card needs to snap to tableau

class Solitare {
    var stock = [Card]()
    var waste = [Card]()
    var tableaus = [[Card]]()
    var foundations = [Card]()
    
    enum Version: String, CaseIterable {
        case Klondike
    }
    
    enum PassAllowance: String, CaseIterable {
        case one = "1"
        case three = "3"
        case infinite = "infinite"
    }
    
    func setup() {
        foundations = []
        stock = []
        tableaus = []
        waste = []
         
        buildStock()
        //print(stock)
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
        GameView()
        //SettingsView()
        //MenuView()
    }
}
