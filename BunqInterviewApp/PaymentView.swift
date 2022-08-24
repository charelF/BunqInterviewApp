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
    
    var body: some View {
        VStack {
            
            Spacer()
            
//            Text("Payment")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.init(top: 0, leading: 15, bottom: 10, trailing: 15))
            
            TextField("0.00", value: $value, formatter: Payment.numberFormatter)
//                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            TextField("Recipient", text: $recipient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
            Button(action: {
                Payment.add(value: value, recipient: recipient)
                value = 0
                recipient = ""
                showKeyboard = false
            }, label: {
                Text("Send")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            })
            .padding(5)
            .frame(width: 100, height: 40)
            .background(Color.black)
            .cornerRadius(20)
            
//            Spacer()
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
            .previewInterfaceOrientation(.portrait)
    }
}
