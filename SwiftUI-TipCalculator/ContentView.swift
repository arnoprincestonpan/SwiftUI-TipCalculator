//
//  ContentView.swift
//  SwiftUI-TipCalculator
//
//  Created by Arno Pan on 2023-07-13.
//

import SwiftUI

struct ContentView: View {
    @State var amount = 0.00
    @State var tipPercent = 15.0
    
    var sample1: Transaction = Transaction(number: 1, date: Date.now, amount: 10.00, tip: 1.00)
    @State var myTransactions = [Transaction]()

    
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
//                TextField("Amount", text: $amount).keyboardType(.decimalPad)
                TextField("Enter your Bill", value: $amount, format: .number)
            }
            HStack {
                Slider(value: $tipPercent, in: 1...30, step: 1.0)
                Text("\(Int(tipPercent))%")
            }

            VStack(alignment: .leading) {
                Text("Tip Amount: \(amount * tipPercent / 100, format: .currency(code: "CAD"))")
                Text("Total Amount: \(amount * (1 + tipPercent / 100), format: .currency(code: "CAD"))")
                Button {
                    addRandom()
                } label: {
                    Text("Add to Recent")
                }
                .buttonStyle(.bordered)
            }
            
            VStack{
                HStack{
                    Image(systemName: "clock.fill")
                        .imageScale(.medium)
                        .foregroundColor(.black)
                        .font(.title)
                    Text("Recent")
                        .font(.title)
                        .fontWeight(.light)
                }
                VStack{
                    HStack{
                        Button {
                            clearAllTransactions()
                        } label: {
                            Text("Clear")
                                .foregroundColor(Color.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        Button {
                            saveTransactions()
                        } label: {
                            Text("Save All")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }

                    HStack{
                        Text("#")
                        Spacer()
                        Text("Date")
                        Spacer()
                        Text("Amount")
                        Spacer()
                        Text("Tip Amount")
                    }
                    .font(.headline)
                    
                    List(myTransactions, id: \.number) { transaction in
                        HStack {
                            Text("\(transaction.number)")
                            Spacer()
                            Text("\(transaction.date.formatted())")
                            Spacer()
                            Text(transaction.amount, format: .currency(code: "CAD"))
                            Spacer()
                            Text(transaction.tip, format: .currency(code: "CAD"))
                        }
                    }
                    .listStyle(.plain)
                }
            }.padding(.top, 16)
            Spacer()
        }.padding()
    }
    
    func addRandom() {
        myTransactions.append(Transaction(number: myTransactions.count + 1, date: Date.now, amount: amount, tip: amount * (1 + tipPercent)/100))
    }
    
    func saveCurrentTransaction() {
        
    }
    
    func loadTransactions() {
        if let data = UserDefaults.standard.data(forKey: "previousTransactions") {
            do {
                let decoder = JSONDecoder()
                let decodedTransactions = try decoder.decode([Transaction].self, from: data)
                myTransactions = decodedTransactions
            } catch {
                print("Failed to decode transactions:", error)
            }
        } else {
            myTransactions = []
        }
    }
    
    func clearAllTransactions(){
        myTransactions.removeAll()
    }
    
    func saveTransactions(){
        if myTransactions.count != 0 {
            do {
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(myTransactions)
                UserDefaults.standard.set(encodedData, forKey: "previousTransactions")
            } catch {
                print("Failed to encode transactions: ", error)
            }
        } else {
            print("No transactions was added. You have done no calculations.")
        }
    }
}

struct Transaction: Codable {
    let number: Int
    let date: Date
    let amount: Double
    let tip: Double
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
