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
            Text("abc")
                .foregroundColor(sortByMoneyDescending ? .blue : .gray)
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
            Text("abc")
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
            Text("abc")
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
            Text("abc")
                .foregroundColor(sortByPersonCountAscending ? .blue : .gray)
        }
    }
}


