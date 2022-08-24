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
    
    @State var fetched: Bool = false
    
    private func awaitPayments() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 1 in 10 chance that the payment request did not work, then we dont show the user an error but instead silently retry
        let randomInt = Int.random(in: 0...10)
        if randomInt == 0 {
            fetched = false
        } else {
            fetched = true
        }
    }

    var body: some View {
        NavigationView {
            if !fetched {
                ProgressView()
                    .task({
                        while !fetched {
                            await awaitPayments()
                        }
                    }
                    )
            } else {
                List {
                    ForEach(payments) { payment in
                        NavigationLink {
                            Text("You sent \(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                            
                            Text(payment.timestamp!, formatter: Payment.dateFormatter)
                                .font(.footnote)
                            
                        } label: {
                            VStack {
                                Text("\(Payment.numberFormatter.string(from: NSNumber(value: payment.value))!) to \(payment.recipient!)")
                            }
                        }
                    }
                }
                .navigationTitle("Payment History")
                .refreshable {
                    await awaitPayments()
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
