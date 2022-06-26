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
    @State private var recognizedString = ""
    @State private var decryptedString = ""
    @State private var key = ""
    @State private var neededKey = false
    var encryptions = ["Base64", "Reverse", "Caesar", "Skip", "AES-128"]
    @State private var selectedEncryption = "Select"
    var decipher = Dechiper()
    
    var body: some View {
        VStack {
            HStack{
                Text("Spacecryption")
                    .font(.system(size:40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    guard !isRecognizing else { return }
                    showScanner = true
                }, label: {
                    HStack {
                        Image(systemName: "doc.text.viewfinder")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.systemIndigo))
                    .cornerRadius(100)
                })
            }
            .padding(25)
            
            ZStack(alignment: .bottom) {
                if isRecognizing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemIndigo)))
                        .padding(.bottom, 20)
                }
                VStack{
                    ScanTextField("Input text...", text: $recognizedString)
                        .padding(8)
                        .frame(height: 30)
                        .frame(maxWidth: 300)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding()
                    
                    Picker("Decryption", selection: $selectedEncryption) {
                        ForEach(encryptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                    
                    if selectedEncryption == "Caesar" || selectedEncryption == "Skip" || selectedEncryption == "AES-128" {
                        
                        TextField(selectedEncryption == "AES-128" ? "Key" : (selectedEncryption == "Caesar" ? "Shift" : "SkipSize"), text: $key)
                            .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 70)
                            .border(Color(.blue))
                            .padding()
                            .keyboardType(selectedEncryption == "Caesar" || selectedEncryption == "Skip" ? .numberPad : .default)
                    }
                    
                    
                    TextEditor(text: .constant("Encrypted Text"))
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 200)
                        .border(Color(.blue))
                        .padding()
                       
                    
                    Button(action: {
                        print("Azione")
                    }, label: {
                        HStack {
                            Image(systemName: "lock.open")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                            
                            Text("Decrypt")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        //                        .frame(height: 56)
                        .frame(width: 200, height: 60)
                        .background(Color(UIColor.systemIndigo))
                        .cornerRadius(100)
                    })
                }
            }
        }
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
