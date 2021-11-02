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



extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
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

