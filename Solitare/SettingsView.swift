//
//  SettingsView.swift
//  Solitare
//
//  Created by Nathan Olson on 1/24/21.
//

import SwiftUI

struct SettingsView: View {
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
                Text("Icons: Playing Cards by Vadim Solomakhin from the Noun Project")
                Text("Fonts: CARD CHARACTERS computer font v1.1 ©2003, 2009 Harold Lohner HLohner@aol.com http://www.haroldsfonts.com")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}

