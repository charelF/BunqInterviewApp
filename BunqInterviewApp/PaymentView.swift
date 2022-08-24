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
    @State var showTransaction: Bool = false
    
    var body: some View {
        VStack {
            
            TextField("0.00", value: $value, formatter: Payment.numberFormatter)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Recipient", text: $recipient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Send") {
                showTransaction = true
                Payment.add(value: value, recipient: recipient)
                value = 0
                recipient = ""
            }
            
            if showTransaction {
                Text("\(value)")
                
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
