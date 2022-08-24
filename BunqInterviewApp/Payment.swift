//
//  Payment.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 23/08/2022.
//

import Foundation

extension Payment {
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
    
    static func add(value: Double, recipient: String) {
        print(value, recipient)
        if recipient.isEmpty {
            return
        }
        
        let viewContext = PersistenceController.shared.container.viewContext
        let payment = Payment(context: viewContext)
        payment.recipient = recipient
        payment.value = value
        payment.timestamp = Date()
            
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension Payment {
    static let previewPayments: [Payment] = {
        let viewContext = PersistenceController.preview.container.viewContext
        let payment = Payment(context: viewContext)
        payment.recipient = "TEST"
        payment.value = 99.99
        payment.timestamp = Date()
        let payments: [Payment] = [payment]
        return payments
    }()
}

enum PaymentState {
    case loading
    case success
    case fail
}


