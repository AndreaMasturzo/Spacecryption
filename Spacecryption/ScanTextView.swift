//
//  ScanTextField.swift
//  Spacecryption
//
//  Created by Andrea Masturzo on 26/06/22.
//

import SwiftUI

public struct ScanTextView: UIViewRepresentable {
    public let placeholder: String
    @Binding public var text: String
    
    public init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public func makeUIView(context: Context) -> some UIView {
        let textFromCamera = UIAction.captureTextFromCamera(responder: context.coordinator, identifier: nil)
        let image = UIImage(systemName: "text.viewfinder")
        let toolbarItem = UIBarButtonItem(title: nil, image: image, primaryAction: textFromCamera, menu: nil)
        
        let textView = UITextView()
        let bar = UIToolbar()
        
        
        bar.items = [toolbarItem]
        bar.sizeToFit()
        textView.inputAccessoryView = bar
        textView.delegate = context.coordinator
        textView.text = text
        
        
        return textView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        if let uiView = uiView as? UITextView {
            uiView.text = text
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: UIResponder, UIKeyInput, UITextViewDelegate {
        public let parent: ScanTextView
        
        public var hasText: Bool {
            !parent.text.isEmpty
        }
        
        public init(_ parent: ScanTextView) {
            self.parent = parent
        }
        
        public func insertText(_ text: String) {
            parent.text = text
        }
        
        public func deleteBackward() { }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            parent.text = textView.text ?? ""
        }
    }
}
