//
//  UMSalaryPubV4App.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 10/21/21.
//

import SwiftUI

@main
struct UMSalaryPubV4App: App {
    /// AppState is used by the "Home" button to reset the app and to bring the user back to the HomeScreenView.
    /// https://stackoverflow.com/questions/65309064/reset-main-content-view-swift-ui/65309299
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
    @Published var purchased: YearPurchased = .none
    
    enum YearPurchased {
        case none
        case twentyTwo
    }
    init(){
        if StoreKitManager.shared.purchasedYears.count > 0 {
            AppState.shared.purchased = .twentyTwo
        }
    }
}
