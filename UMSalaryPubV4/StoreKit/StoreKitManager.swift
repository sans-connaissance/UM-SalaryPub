//
//  StoreKitManager.swift
//  UMSalaryPubV4
//
//  Created by David Malicke on 1/2/23.
//

import Foundation
import StoreKit

class StoreKitManager: ObservableObject {
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedYears: [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    private let productDict: [String: String]
    
    static let shared = StoreKitManager()
    
    init() {
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    print("Transaction Failed")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print("Failed - error retrieving products \(error)")
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        
        let result = try await product.purchase()
        
        switch result {
        case .success(let verficationResult):
            let transaction = try checkVerified(verficationResult)
            await updateCustomerProductStatus()
            await transaction.finish()
            return transaction
        case .pending, .userCancelled:
            return nil
        @unknown default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedYears: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                if let year = storeProducts.first(where: { $0.id == transaction.productID}) {
                    purchasedYears.append(year)
                }
            } catch {
                print("Transaction failed")
            }
            self.purchasedYears = purchasedYears
        }
    }
    
    func isPurchased(_ product: Product) async throws -> Bool {
        return purchasedYears.contains(product)
    }
    
    enum YearPurchased {
        case none
        case twentyTwo
    }
}

public enum StoreError: Error {
    case failedVerification
}
