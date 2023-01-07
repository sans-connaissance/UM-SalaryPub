//
//  YearItem.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 1/2/23.
//

import SwiftUI
import StoreKit

struct YearItem: View {
    @ObservedObject var storeKit: StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .font(.footnote)
            } else {
                Text(product.displayPrice)
            }
        }
        .onChange(of: storeKit.purchasedYears) { year in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                    AppState.shared.purchased = .twentyTwo
            }
        }
    }
}

struct OldYearItem: View {
    @State var isPresented: Bool = false
    let year: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Button {
                isPresented.toggle()
            } label: {
                Text(Image(systemName: "checkmark"))
                        .bold()
                        .font(.footnote)
            }
            .buttonStyle(.borderedProminent)
            Text("\(year) U of M Salary Data")
        }
        .alert(isPresented: $isPresented) {
            Alert(title: Text("\(year) U of M Salary Data is loaded."))
        }
    }
}
