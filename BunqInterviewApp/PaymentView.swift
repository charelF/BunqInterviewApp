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
    @State var outcome: Bool = false
    @State private var showingPopover = false
    @State var paymentState: PaymentState = .loading
    
    @Environment(\.colorScheme) var colorScheme
    
    private func sendPayment() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let randomInt = Int.random(in: 0...10)
        if randomInt != 0 {
            paymentState = .success
        } else {
            paymentState = .fail
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Payment")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 50, leading: 15, bottom: 10, trailing: 15))
            
            TextField("", value: $value, formatter: Payment.numberFormatter)
//                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            TextField("Recipient", text: $recipient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            Button(action: {
                paymentState = .loading
                Task {
                    await sendPayment()
                    if paymentState == .success {
                        Payment.add(value: value, recipient: recipient)
                    }
                    value = 0
                    recipient = ""
                }
                showingPopover = true
                showKeyboard = false
                
            }, label: {
                Text("Send")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
            })
            
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.white : Color.black)
            .cornerRadius(8)
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            Spacer()
        }
        .popover(isPresented: $showingPopover) {
            ZStack {
                switch paymentState {
                case .loading:
                    ProgressView()
                case .success:
                    Color.green
                    Text("Success!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .padding()
                case .fail:
                    Color.red
                    VStack {
                        Text("Payment failed")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .padding()
                        Text("please try again")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
            .previewInterfaceOrientation(.portrait)
    }
}
