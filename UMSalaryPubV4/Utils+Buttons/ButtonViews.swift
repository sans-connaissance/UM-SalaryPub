//
//  Buttons.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI

///SortListButton and  enum SortOption work together to provide buttons for sorting the results from the FetchRequests used to populate  PersonListView, TitleListView, DepartmentListView, CampusListView, etc.
struct SortListButton: View {
    var selected: SortOption
    @Binding var sortButtons: [SortOption: Bool]
    
    var body: some View {
        Button {
            listBy(sortOption: selected)
        } label: {
            Text("\(selected.title)")
                .foregroundColor(sortButtons[selected] ?? false ? .blue : .gray)
        }
    }
    
    /// Ensures that only the selected sort button is set to true, thus listing the FetchRequest results according to that SortOption.
    func listBy(sortOption: SortOption) {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[sortOption] = true
    }
}

enum SortOption: String, CaseIterable {
    case sortAlphabetically
    case sortByMoneyDescending
    case sortByMoneyAscending
    case sortByPersonCountDescending
    case sortByPersonCountAscending
    
    static let personList: [SortOption] = [.sortAlphabetically, .sortByMoneyDescending, .sortByMoneyAscending]
    
    var title: Text {
        switch self {
        case .sortAlphabetically:
            return Text("abc")
        case .sortByMoneyDescending:
            return Text("$$$")
        case .sortByMoneyAscending:
            return Text("$")
        case .sortByPersonCountDescending:
            return Text(Image(systemName: "person.3.fill"))
        case .sortByPersonCountAscending:
            return Text(Image(systemName: "person.fill"))
        }
    }
}

struct CloseInsightViewButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Close").font(.subheadline)
                .accessibility(identifier: "closeInsightViewButton")
        }).padding()
    }
}

struct InsightsButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ///Trying out one of the new .buttonStyles introduced in iOS 15.
        if #available(iOS 15.0, *) {
            insightButtonStyle.buttonStyle(.borderedProminent)
        } else {
            insightButtonStyle
        }
    }
    
    var insightButtonStyle: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack(alignment: .center, spacing: 2) {
                Image(systemName: "chart.bar.xaxis")
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)).opacity(0.6)
                Text("Insights")
                    .textStyle(DetailData())
                    .accessibility(identifier: "insightButton")
            }
        }
    }
}

struct PurchaseButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ///Trying out one of the new .buttonStyles introduced in iOS 15.
        if #available(iOS 15.0, *) {
            purchaseButtonStyle.buttonStyle(.borderedProminent)
        } else {
            purchaseButtonStyle
        }
    }
    
    var purchaseButtonStyle: some View {
        Button {
            isPresented.toggle()
            AppState.shared.purchased = .twentyTwo
            AppState.shared.viewID = UUID()
        } label: {
            HStack(alignment: .center, spacing: 2) {
                Text("Buy Now")
                    .textStyle(DetailData())
                    .accessibility(identifier: "purchaseButton")
            }
        }
        .onChange(of: AppState.shared.purchased) { _ in
            AppState.shared.presentPurchaseAlert = false
        }
    }
}

/// Resets app
struct HomeButton: View {
    var body: some View {
        Button {
            AppState.shared.viewID = UUID()
        } label: {
            Image(systemName: "house")
                .accessibility(identifier: "homeButton")
        }
    }
}
