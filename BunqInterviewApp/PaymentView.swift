//
//  PaymentView.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 23/08/2022.
//

import SwiftUI

struct PaymentView: View {
    
    @State var value: Double = 0
    @State var recipient: String = ""
    @FocusState var showKeyboard: Bool
    @State var paymentState: PaymentState = .idle
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            Text("Payment")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 48, leading: 15, bottom: 10, trailing: 15))
            
            TextField("", value: $value, formatter: Payment.numberFormatter)
                // wanted to use numberPad but then we cant make a comma or dot as decimal separator
                //.keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            TextField("Recipient", text: $recipient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            Button(action: {
                // when clicking the button, the paymenState is set to .loading in the main thread.
                // In an async thread, we do the actual request and update the paymenState, propagate the changes to the UI
                // Finally after some waiting, we set the state again to .idle to display the proper button again.
                paymentState = .loading
                Task {
                    paymentState = await Payment.sendPayment(value: value, recipient: recipient)
                    value = 0
                    recipient = ""
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    paymentState = .idle
                }
                showKeyboard = false
                
            }, label: {
                switch paymentState {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                case .success:
                    Text("Success")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                case .fail:
                    Text("Fail")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                case .idle:
                    Text("Send")
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                }
            })
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(
                // very ugly but could not make a switch statement work for some reason
                paymentState == .idle ? (colorScheme == .dark ? Color.white : Color.black) :
                    (paymentState == .loading ? Color.blue :
                        (paymentState == .success ? Color.green : Color.red
                        )
                    )
                )
            .cornerRadius(8)
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            Spacer()
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
            .previewInterfaceOrientation(.portrait)
    }
}
