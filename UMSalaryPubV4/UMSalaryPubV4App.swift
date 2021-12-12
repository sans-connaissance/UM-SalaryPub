//
//  UMSalaryPubV4App.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import SwiftUI

@main
struct UMSalaryPubV4App: App {
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().id(appState.viewID)
        }
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var viewID = UUID()
}
