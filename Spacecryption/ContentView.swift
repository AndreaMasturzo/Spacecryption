//
//  ContentView.swift
//  Spacecryption
//
//  Created by Andrea Masturzo on 26/06/22.
//

import Foundation
import SwiftUI

let message = "C52TB!9DC6! T6BTC!TDB2Tx T6B9TC!Tz!00D 6zxC2TC29202CAHTC!TC52T0x6 TBCxC6! WTq52T 2GCT82HT6BTJS"

let decodedData = Data(base64Encoded: message)!
let decodedString = String(data: decodedData, encoding: .utf8)!


struct ContentView: View {
    
    var decipher = Dechiper()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
