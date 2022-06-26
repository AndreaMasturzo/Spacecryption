//
//  ContentView.swift
//  Spacecryption
//

import Foundation
import SwiftUI
import simd
import ScanTextField

struct ContentView: View {
    
    @ObservedObject var recognizedContent = RecognizedContent()
    @State private var showScanner = false
    @State private var isRecognizing = false
    @State private var encryptedString = ""
    @State private var decryptedString = ""
    @State private var key = ""
    @State private var neededKey = false
    var encryptions = ["Base64", "Reverse", "Caesar", "Skip", "AES-128"]
    @State private var selectedEncryption = "Select"
    var decipher = Dechiper()
    
    var body: some View {
        VStack {
            Text("Spacecryption")
                .font(.system(size:40))
                .fontWeight(.bold)
                .padding(25)
            
            ZStack(alignment: .bottom) {
                VStack{
                    ScanTextView("Input text...", text: $encryptedString)
                        .padding(8)
                        .frame(maxWidth: 300)
                        .background(.gray.opacity(0.2))
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
                        
                    
                    Button(action: {
                        if selectedEncryption == "Base64" {
                            decryptedString = decipher.base64(string: encryptedString)
                        } else if selectedEncryption == "Reverse" {
                            decryptedString = decipher.reverse(string: encryptedString)
                        } else if selectedEncryption == "Caesar" {
                            decryptedString = decipher.cesarDecrypt(message: encryptedString, cesarShift: Int(key) ?? 0)
                        } else if selectedEncryption == "Skip" {
                            decryptedString = decipher.skipCipher(string: encryptedString, jump: Int(key) ?? 0)
                        } else if selectedEncryption == "AES-128" {
                            print("Din Don")
                        }
                        print("decoding")
                    }, label: {
                        HStack {
                            Image(systemName: "lock.open")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                            
                            Text("Decrypt")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .frame(width: 200, height: 60)
                        .background(Color(UIColor.systemIndigo))
                        .cornerRadius(100)
                    })
                }
            }
        }
        .onChange(of: decryptedString, perform: { newValue in
            UIApplication.shared.endEditing()
        })
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
