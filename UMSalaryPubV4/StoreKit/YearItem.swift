//
//  YearItem.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 1/2/23.
//

import SwiftUI
import StoreKit

@available(iOS 15.0, *)
struct YearItem: View {
    @ObservedObject var storeKit: StoreKitManager
    @State var isPurchased: Bool = false
    var product: Product
    
    var body: some View {
        VStack {
            if isPurchased {
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {
                Text(product.displayPrice)
                    .padding(10)
            }
        }
        .onChange(of: storeKit.purchasedYears) { year in
            Task {
                isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
        }
    }
}

