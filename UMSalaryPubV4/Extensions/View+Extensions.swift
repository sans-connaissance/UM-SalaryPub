

import Foundation
import SwiftUI

///This extension is only used in the More Info Views, but I think it's pretty cool. Originally written by Mohammad Azam.
extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
/// Enables custom FontStyles used through the app
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

/// NumberFormatter used in Person, Title, Department, and Campus ViewModels
extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
/// NumberFormatter used in Person, Title, Department, and Campus ViewModels
extension Double {
    func noCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
