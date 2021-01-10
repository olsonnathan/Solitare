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
    
    @State var showingAlert = false
    @Environment(\.presentationMode) var presentation

    init() { UITableView.appearance().backgroundColor = .clear }
    
    var body: some View {
        NavigationView {
            Text("Game Board")
        }
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

struct SettingsView: View {
    // weird space on top of list caused by apple bug
    // TODO: fix spacing when apple provides solution
    // TODO: abstract info button to remove duplicate code
    // TODO: replace text with info icon image
    // TODO: convert version stepper to picker view
    
    @State var drawCount = 1
    @State var passAllowance = 2
    @State var enablePassing = true
    @State var showingAlert = false
    @State var version = 0
    
    init() { UITableView.appearance().backgroundColor = .clear }
    
    var body: some View {
        List {
            Section(header: Text("Game Type")) {
                HStack {
                    // Stepper(value: $version, in: 0...Solitare.Version.allCases.count, step: 0) {
                    // Text(Solitare.Version.allCases[version].rawValue)
                    // }
                    Text(Solitare.Version.allCases[version].rawValue)
                    Spacer()
                    Button(action: { self.showingAlert = true },
                           label: {
                            Text("Info Button")
                           }).alert(isPresented: $showingAlert, content: {
                            Alert(title: Text("Title"),
                                  message: Text("message"),
                                  dismissButton: .cancel())
                           })
                }
            }
            
            Section(header: Text("Game Settings")) {
                HStack {
                    Toggle("Enable Passing", isOn: $enablePassing)
                    Button(action: { self.showingAlert = true },
                           label: { Text("Info Button") }
                    ).alert(isPresented: $showingAlert, content: {
                                Alert(title: Text("Title"),
                                      message: Text("message"),
                                      dismissButton: .cancel())})
                }
                
                if enablePassing {
                    HStack {
                        Stepper(value: $drawCount, in: 1...3, step: 2) {
                            Text("Draw \(drawCount)")
                        }
                        Button(action: { self.showingAlert = true },
                               label: { Text("Info Button") }
                        ).alert(isPresented: $showingAlert, content: {
                                    Alert(title: Text("Title"),
                                          message: Text("message"),
                                          dismissButton: .cancel())})
                    }
                    HStack {
                        Stepper(value: $passAllowance, in: 0...2, step: 1) {
                            let plural = passAllowance == 0 ? "" : "s"
                            Text("Pass \(Solitare.PassAllowance.allCases[passAllowance].rawValue) time\(plural)")
                        }
                        Button(action: { self.showingAlert = true },
                               label: {
                                Text("Info Button")
                               }).alert(isPresented: $showingAlert, content: {
                                Alert(title: Text("Title"),
                                      message: Text("message"),
                                      dismissButton: .cancel())
                               })
                    }
                }
            }
            Section(header: Text("Licenses")) {
                Text("Playing Cards by Vadim Solomakhin from the Noun Project")
            }
        }.listStyle(GroupedListStyle())
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
        SettingsView()
        MenuView()
        GameView()
    }
}
