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
        sortDescriptors: [NSSortDescriptor(keyPath: \Payment.timestamp, ascending: false)],
        animation: .default
    ) private var payments: FetchedResults<Payment>
    
    @State var paymentState: PaymentState = .loading
    
    private func loadPayments() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let randomInt = Int.random(in: 0...9)
        if randomInt != 0 {
            paymentState = .success
        } else {
            paymentState = .fail
        }
    }

    var body: some View {
        NavigationView {
            
            switch paymentState {
            case .loading:
                ProgressView().task {
                    await loadPayments()
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
                            await loadPayments()
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
                    await loadPayments()
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
