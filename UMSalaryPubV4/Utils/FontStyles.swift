//
//  FontStyles.swift
//  UMICHSalaryPub (iOS)
//
//  Created by David Malicke on 2/27/21.
//

import SwiftUI

struct SmallGrey: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.gray)
            .lineLimit(nil)
    }
}


struct DetailData: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .lineLimit(nil)
    }
}


struct CustomHeader: View {
    let name: String
    let color: Color

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                    .padding(.leading)
                Spacer()
            }
            Spacer()
        }
        .background(color)
    }
}





