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
//
//                                Text("Scan")
//                                    .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
//                        .frame(height: 56)
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.systemIndigo))
                    .cornerRadius(100)
                    
                })
                
            }.padding(25)
         
            ZStack(alignment: .bottom) {
//                                List(recognizedContent.items, id: \.id) { textItem in
//                                    NavigationLink(destination: TextPreviewView(text: textItem.text)) {
//                                        Text(String(textItem.text.prefix(50)).appending("..."))
//                                    }
//                                }
//
                
                if isRecognizing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemIndigo)))
                        .padding(.bottom, 20)
                }
                VStack{
                    ZStack{
//                        Rectangle()
//                            .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 200)
//                            .foregroundColor(.yellow)
//                            .border(Color(.blue))
//                            .padding()
//                        HStack{
//
//                            Button(action: {
//                                print("Text Inputfcdcdcdfc")
//                            }){ Text("Text Input")
//                                    .frame(minWidth: 0, maxWidth: 160, minHeight: 0, maxHeight: 150)
//                                    .border(Color(.blue))
//                            }
//
//                            Button(action: {
//                                print("Text Inputfcdcdcdfc")
//                            }){ Text("Camera Input")
//                                    .frame(minWidth: 0, maxWidth: 160, minHeight: 0, maxHeight: 150)
//                                    .border(Color(.blue))
//                            }
//                        }
                        
                    }
                    ZStack{
                        ScanTextField("Input text...", text: $recognizedString)
                            .padding(8)
                            .frame(height: 30)
                            .frame(maxWidth: 300)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding()
//                        TextField("Eecrypted Text", text: Value)
//                            .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 200)
//                            .border(Color(.blue))
//                            .padding()
//                        HStack{
//                            Spacer()
//
//                        }
                        
                    }
                    
//                    Spacer()
                    TextField("Key", text: .constant(""))
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 70)
                        .border(Color(.blue))
                        .padding()
//                    HStack{
//                        Label("Key:", systemImage: "key")
//                        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
//                            /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
//                            /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
//                        }
//                        Spacer()
//                    }.padding(25)
                    
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
                    
                    
//                    Text("TEST")
//                        .foregroundColor(.black)
//                    Text("TEST2")
//                        .foregroundColor(.black)
//                    Text("TEST3")
//                        .foregroundColor(.black)
                }
            }
//            .navigationTitle("Spacecryption")
//            .navigationBarItems(trailing: Button(action: {
//                guard !isRecognizing else { return }
//                showScanner = true
//            }, label: {
//                HStack {
//                    Image(systemName: "doc.text.viewfinder")
//                        .renderingMode(.template)
//                        .foregroundColor(.white)
//
//                    Text("Scan")
//                        .foregroundColor(.white)
//                }
//                .padding(.horizontal, 16)
//                .frame(height: 36)
//                .background(Color(UIColor.systemIndigo))
//                .cornerRadius(18)
//            }))
            
        }
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    isRecognizing = true
                    
                    TextRecognition(scannedImages: scannedImages,
                                    recognizedContent: recognizedContent) {
                        // Text recognition is finished, hide the progress indicator.
                        isRecognizing = false
                    }
                    .recognizeText()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                showScanner = false
                
            } didCancelScanning: {
                // Dismiss the scanner controller and the sheet.
                showScanner = false
            }
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
