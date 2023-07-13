//
//  ContentView.swift
//  SwiftUI-TipCalculator
//
//  Created by Arno Pan on 2023-07-13.
//

import SwiftUI

struct ContentView: View {
    @State var total = "0.00"
    @State var tipPercent = 15.0
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .font(.title)
                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            HStack{
                Text("$")
                TextField("Amount", text: $total).keyboardType(.decimalPad)
            }
            HStack {
                Slider(value: $tipPercent, in: 1...30, step: 1.0)
                Text("\(Int(tipPercent))%")
            }
            if let totalNumber = Double(total){
                VStack(alignment: .leading) {
                    Text("Tip Amount: $\(totalNumber * tipPercent / 100, specifier: "%0.2f")")
                    Text("Total Amount: $\(totalNumber + totalNumber * tipPercent / 100, specifier: "%0.2f")")
                }
            } else {
                Text("Please enter a numeric value.")
            }
            VStack{
                HStack{
                    Image(systemName: "clock.fill")
                        .imageScale(.medium)
                        .foregroundColor(.black)
                        .font(.title)
                    Text("History")
                        .font(.title)
                        .fontWeight(.light)
                }
                VStack{
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Clear")
                                .foregroundColor(Color.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        Button {
                            
                        } label: {
                            Text("Save Current")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                    HStack{
                        Text("Number")
                        Text("Date")
                        Text("Amount")
                    }
                }
            }.padding(.top, 16)
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
