///Adapted from https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("search", text: $searchText, onEditingChanged: { _ in
                    showCancelButton = true
                }, onCommit: { print("onCommit") }).foregroundColor(.primary)

                Button(action: {
                    searchText = " "
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == " " ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            .disableAutocorrection(true)

            if showCancelButton {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    searchText = " "
                    showCancelButton = false
                }.foregroundColor(Color(.systemBlue))
            }
        }.padding(.horizontal)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }

    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
