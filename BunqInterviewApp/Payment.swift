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
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
    
//    static func getPreviewPayments(vc: NSManagedObjectContext) -> [Payment] {
//        let payment = Payment(context: vc)
//        payment.recipient = "TEST"
//        payment.value = 99.99
//        payment.timestamp = Date()
//        let payments: [Payment] = [payment]
//        return payments
//
//    }
}

//class Payment {
//
//    // We consider a very simple payment class only
//    // which represents a payment by its recipient and the value
//
//    let value: Double
//    let recipient: String
//    let timestamp: Date
//
//    init(value: Double, recipient: String) {
//        self.value = value
//        self.recipient = recipient
//        self.timestamp = Date.now
//
//    }
//}


