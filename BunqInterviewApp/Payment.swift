//
//  Payment.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 23/08/2022.
//

import Foundation

extension Payment {
    // We are working with extensions to the Payment class since the original class is defined
    // by Core Data and thus not easily accessible
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
}

extension Payment {
    static func sendPayment(value: Double, recipient: String) async -> PaymentState {
        // Sends a Payment. This function is async such that the main UI of the app stays responsive.
        
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    
        if recipient.isEmpty {
            return .fail
        }
        
        let randomInt = Int.random(in: 0...9)
        if randomInt == 0 {
            // 10% chance of failed network request
            return .fail
        } else {
            let viewContext = PersistenceController.shared.container.viewContext
            let payment = Payment(context: viewContext)
            payment.recipient = recipient
            payment.value = value
            payment.timestamp = Date()
            do {
                try viewContext.save()
            } catch {
                return .fail
            }
        }
        return .success
    }
    
    static func loadPayments() async -> PaymentState {
        // not a very nice function, as it changes the paymentState irrespective of whether the payments went through or not
        // instead doing the fetch request here in this function would be nicer
        // however that is not trivial to do, and I had trouble implementing it in SwiftUI as the
        // @FetchRequest decorator is the preferred way
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let randomInt = Int.random(in: 0...9)
        if randomInt != 0 {
            return .success
        } else {
            return .fail
        }
    }
}

enum PaymentState {
    case loading
    case success
    case fail
    case idle
}


