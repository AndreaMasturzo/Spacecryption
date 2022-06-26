//
//  ContentView.swift
//  Spacecryption
//

import Foundation
import SwiftUI
import simd

struct ContentView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemIndigo.withAlphaComponent(0.2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemIndigo], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
    }
    
    @State private var selectedView = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedView) {
                Text("Encrypt").tag(0)
                Text("Decrypt").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.top, 25)
            .padding(.leading, 75)
            .padding(.trailing, 75)
            Spacer()
            Text("SpaceCipher")
                .italic()
                .font(.system(size:40))
                .fontWeight(.bold)
                .padding(25)
            
            if selectedView == 0 {
                EncipherView()
            } else if selectedView == 1 {
              DecipherView()
            }
            Spacer()
            
            
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
