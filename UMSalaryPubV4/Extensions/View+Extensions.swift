//
//  View+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
