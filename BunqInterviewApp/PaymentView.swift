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
    
    
    
    var body: some View {
        VStack {
            
            Text("Payment")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 50, leading: 15, bottom: 10, trailing: 15))
            
            TextField("0.00", value: $value, formatter: Payment.numberFormatter)
//                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            TextField("Recipient", text: $recipient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($showKeyboard)
                .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
            
            Button(action: {
                showingPopover = true
                outcome = Payment.add(value: value, recipient: recipient)
                print(outcome)
                value = 0
                recipient = ""
                showKeyboard = false
                
            }, label: {
                Text("Send")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            })
            
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(8)
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            Spacer()
        }
        .popover(isPresented: $showingPopover) {
            ZStack {
                if outcome {
                    Color.green
                    Text("Success!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .padding()
                } else {
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
