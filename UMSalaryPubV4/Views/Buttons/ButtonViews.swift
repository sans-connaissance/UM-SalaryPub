//
//  Buttons.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI


struct SortListButton: View {
    var selected: SortOption
    // Should sortButtons be a type?
    @Binding var sortButtons: [SortOption : Bool]
    
    var body: some View {
        Button {
            listBy(sortOption: selected)
        } label: {
            Text("\(selected.title)")
                .foregroundColor(sortButtons[selected] ?? false ? .blue : .gray)
        }
    }
    func listBy(sortOption: SortOption) {
        SortOption.allCases.forEach { button in
            sortButtons[button] = false
        }
        sortButtons[sortOption] = true
    }
}

struct ChartSwitch: View {
    @Binding var isOn: Bool
    
    var switchTitle: String
    var switchData: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                label
                Spacer()
                switchToggle

            }
        }
    }
    var label: some View {
        VStack {
            Text(switchTitle).textStyle(SmallGrey())
            Text(switchData).font(.subheadline)
        }.padding([.top, .leading])
    }
    
    var switchToggle: some View {
     
        Toggle("", isOn: $isOn)
            .toggleStyle(SwitchToggleStyle(tint: .init(.systemGreen)))
            .labelsHidden()
            .padding(.trailing)
    }

}


enum SortOption: String, CaseIterable {
    case sortByMoneyDescending
    case sortByMoneyAscending
    case sortAlphabetically
    case sortByPersonCountDescending
    case sortByPersonCountAscending
    
    static let personList: [SortOption] = [.sortByMoneyDescending, .sortByMoneyAscending, .sortAlphabetically]
    
    var title: Text  {
        switch self {
        case .sortByMoneyDescending:
            return Text("$$$")
        case .sortByMoneyAscending:
            return Text("$")
        case .sortAlphabetically:
            return Text("abc")
        case .sortByPersonCountDescending:
            return Text(Image(systemName: "person.3.fill"))
        case .sortByPersonCountAscending:
            return Text(Image(systemName: "person.fill"))
        }
    }
}




struct CloseInsightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button( action: {
            presentationMode.wrappedValue.dismiss()
        },  label: {
            Text("Close").font(.subheadline)}).padding()
    }
}

struct InsightsButton: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            isPresented.toggle()}){
                HStack(alignment: .center, spacing: 2){
                    Image(systemName: "chart.bar.xaxis").rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)).opacity(0.6)
                    Text("Insights")
                        .textStyle(DetailData())
                }
            }
    }
}

