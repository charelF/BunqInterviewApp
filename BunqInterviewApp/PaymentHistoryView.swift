//
//  PaymentHistoryView.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 24/08/2022.
//

import SwiftUI

struct PaymentHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // it would have been nicer to do this fetchrequest manually the same way we perform the sendPayment in the PaymentView
    // However CoreData makes it very easy to be used with @FetchRequest and very hard to do otherwhise
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Payment.timestamp, ascending: false)],
        animation: .default
    ) private var payments: FetchedResults<Payment>
    
    // Here the initial paymentState is .loading instead of .idle
    // As it is undesired to let the user wait for the results, so we
    // immediately start loading them when this view appears.
    @State var paymentState: PaymentState = .loading

    var body: some View {
        NavigationView {
            
            switch paymentState {
            case .loading, .idle: // no separate screen for idle
                ProgressView().task {
                    paymentState = await Payment.loadPayments()
                }
            case .fail:
                ZStack {
                    Color.red
                    VStack {
                        Text("Failed to load payments")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .padding()
                        Text("Tap to reload")
                            .foregroundColor(Color.white)
                    }
                    .onTapGesture {
                        paymentState = .loading
                        Task {
                            paymentState = await Payment.loadPayments()
                        }
                    }
                }
            case .success:
                List {
                    ForEach(payments) { payment in
                        NavigationLink {
                            Text("You sent \(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                                .font(.title)
                                .padding(15)
                            
                            Text(payment.timestamp!, formatter: Payment.dateFormatter)
                                .font(.body)
                                .padding(15)
                            
                        } label: {
                            VStack {
                                Text("\(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                            }
                        }
                    }
                }
                .navigationTitle("Payment History")
                .refreshable {
                    paymentState = await Payment.loadPayments()
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
