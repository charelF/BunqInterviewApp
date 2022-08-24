//
//  PaymentHistoryView.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 24/08/2022.
//

import SwiftUI

struct PaymentHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Payment.timestamp, ascending: true)],
        animation: .default)
    private var payments: FetchedResults<Payment>

    var body: some View {
        NavigationView {
            List {
                ForEach(payments) { payment in
                    NavigationLink {
                        Text("\(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                        
                        Text(payment.timestamp!, formatter: Payment.dateFormatter)
                            .font(.footnote)
                        
                    } label: {
                        VStack {
                            Text("\(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                        }
                    }
                }
            }
        }
    }
}

struct PaymentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
