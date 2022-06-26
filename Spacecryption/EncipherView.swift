//
//  EncypherView.swift
//  Spacecryption
//
//  Created by Andrea Masturzo on 26/06/22.
//

import SwiftUI

struct EncipherView: View {
    
    @State private var encryptedString = ""
    @State private var decryptedString = ""
    @State private var key = ""
    @State private var neededKey = false
    @State private var selectedEncryption = "Select"
    
    var encryptions = ["Base64", "Reverse", "Caesar", "Skip", "AES-128"]
    var decipher = Dechiper()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack{
                ScanTextView("Input text...", text: $encryptedString)
                    .padding(8)
                    .frame(maxWidth: 300)
                    .frame(maxHeight: 80)
                    .background(Color(UIColor.systemIndigo).opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                
                Picker("Decryption", selection: $selectedEncryption) {
                    ForEach(encryptions, id: \.self) {
                        Text($0)
                    }
                }
                .accentColor(Color(UIColor.systemIndigo))
                .pickerStyle(.menu)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
                if selectedEncryption == "Caesar" || selectedEncryption == "Skip" || selectedEncryption == "AES-128" {
                    
                    TextField(selectedEncryption == "AES-128" ? "Key" : (selectedEncryption == "Caesar" ? "Shift" : "SkipSize"), text: $key)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color(UIColor.systemIndigo).opacity(0.2))
                        .cornerRadius(100)
                        .keyboardType(selectedEncryption == "Caesar" || selectedEncryption == "Skip" ? .numberPad : .default)
                }
                
                Text(decryptedString)
                    .textSelection(.enabled)
                    .padding()

                Button(action: {
                    if selectedEncryption == "Base64" {
                        decryptedString = decipher.base64Decoding(string: encryptedString)
                    } else if selectedEncryption == "Reverse" {
                        decryptedString = decipher.reverse(string: encryptedString)
                    } else if selectedEncryption == "Caesar" {
                        decryptedString = decipher.cesarDecrypt(message: encryptedString, cesarShift: Int(key) ?? 0)
                    } else if selectedEncryption == "Skip" {
                        decryptedString = decipher.skipCipherDecryption(string: encryptedString, jump: Int(key) ?? 0)
                    } else if selectedEncryption == "AES-128" {
                        print("Din Don")
                    }
                    print("decoding")
                }, label: {
                    HStack {
                        Image(systemName: "lock")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                        
                        Text("Encrypt")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .frame(width: 200, height: 60)
                    .background(Color(UIColor.systemIndigo))
                    .cornerRadius(100)
                })
                .padding(.top, -40)
            }
        }
        .onChange(of: decryptedString, perform: { newValue in
            UIApplication.shared.endEditing()
        })
    }
}
