//
//  Buttons.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 11/17/21.
//

import SwiftUI


struct SortByMoneyDescendingButton: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = true
            sortByMoneyAscending = false
            sortAlphabetically = false
            sortByPersonCountDescending = false
            sortByPersonCountAscending = false
            
        } label: {
            Text("$$$")
                .foregroundColor(sortByMoneyDescending ? .blue : .gray)
        }
        
    }
}

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


enum SortOption: String, CaseIterable {
    case sortByMoneyDescending
    case sortByMoneyAscending
    case sortAlphabetically
    case sortByPersonCountDescending
    case sortByPersonCountAscending
    
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



struct SortByMoneyAscendingButton: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = true
            sortAlphabetically = false
            sortByPersonCountDescending = false
            sortByPersonCountAscending = false
            
        } label: {
            Text("$")
                .foregroundColor(sortByMoneyAscending ? .blue : .gray)
        }
    }
}


struct SortAlphabeticallyButton: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = false
            sortAlphabetically = true
            sortByPersonCountDescending = false
            sortByPersonCountAscending = false
            
        } label: {
            Text("abc")
                .foregroundColor(sortAlphabetically ? .blue : .gray)
        }
        
    }
}

struct SortByPersonCountDescending: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = false
            sortAlphabetically = false
            sortByPersonCountDescending = true
            sortByPersonCountAscending = false
            
        } label: {
            Image(systemName: "person.3.fill")
                .foregroundColor(sortByPersonCountDescending ? .blue : .gray)
        }
    }
}

struct SortByPersonCountAscending: View {
    
    @Binding var sortByMoneyDescending: Bool
    @Binding var sortByMoneyAscending: Bool
    @Binding var sortAlphabetically: Bool
    @Binding var sortByPersonCountDescending: Bool
    @Binding var sortByPersonCountAscending: Bool
    
    var body: some View {
        Button {
            sortByMoneyDescending = false
            sortByMoneyAscending = false
            sortAlphabetically = false
            sortByPersonCountDescending = false
            sortByPersonCountAscending = true
            
        } label: {
            Image(systemName: "person.fill")
                .foregroundColor(sortByPersonCountAscending ? .blue : .gray)
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

