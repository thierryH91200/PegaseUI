//
//  example1.swift
//  test2
//
//  Created by Thierry hentic on 24/10/2024.
//

import SwiftUI

import SwiftUI

struct OperationDialog: View {
    @State private var linkedAccount = "No transfer"
    @State private var operationName = ""
    @State private var firstName = ""
    @State private var operationDate = Date()
    @State private var mode = "Bank Card"
    @State private var number = ""
    @State private var pointingDate = Date()
    @State private var status = "Engaged"
    @State private var bankStatement = "0"
    @State private var amount = "0.00"
    @State private var subOperationDescription = ""
    @State private var showSaveButton = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Operation")
                .font(.headline)
                .padding(.top, 10)
            
            Text("Creative Mode")
                .font(.subheadline)
                .foregroundColor(.orange)
            
            Form {
                Section {
                    Picker("Linked account", selection: $linkedAccount) {
                        Text("No transfer").tag("No transfer")
                        Text("Transfer").tag("Transfer")
                        // Ajouter d'autres options si nécessaire
                    }
                    TextField("Intitulé", text: $operationName)
                    TextField("Nom", text: $firstName)
                    TextField("Prénom", text: $firstName)
                }
                
                Section {
                    DatePicker("Operation date", selection: $operationDate, displayedComponents: .date)
                    
                    Picker("Mode", selection: $mode) {
                        Text("Bank Card").tag("Bank Card")
                        Text("Cash").tag("Cash")
                        // Ajouter d'autres options si nécessaire
                    }
                    
                    TextField("Number", text: $number)
                    
                    DatePicker("Pointing date", selection: $pointingDate, displayedComponents: .date)
                    
                    Picker("Statut", selection: $status) {
                        Text("Engaged").tag("Engaged")
                        Text("Completed").tag("Completed")
                        // Ajouter d'autres options si nécessaire
                    }
                    
                    TextField("Bank statement", text: $bankStatement)
                    TextField("Amount", text: $amount)
                        .disabled(true)
                }
                
                Section {
                    Text("Sub-operation")
                        .font(.headline)
                    
                    Text("Add a sub-operation")
                        .foregroundColor(.gray)
                        .italic()
                    
                    HStack {
                        Button("+") {
                            print("Add sub-operation")
                        }
                        
                        Button("-") {
                            print("Remove sub-operation")
                        }
                    }
                    
                    Text(subOperationDescription)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .border(Color.gray, width: 1)
                }
                
                Text("No chart Data available.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .border(Color.gray, width: 1)
            }
            .frame(width: 300)
            
            HStack {
                Button("Cancel") {
                    // Action pour annuler
                }
                .keyboardShortcut(.cancelAction)
                
                Button("Save") {
                    // Action pour sauvegarder
                }
                .disabled(!showSaveButton)
                .keyboardShortcut(.defaultAction)
            }
            .padding(.bottom, 10)
        }
        .frame(width: 400, height: 600)
        .padding()
    }
}

struct OperationDialog_Previews: PreviewProvider {
    static var previews: some View {
        OperationDialog()
    }
}
