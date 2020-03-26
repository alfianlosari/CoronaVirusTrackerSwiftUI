//
//  SearchBar.swift
//  CoronaVirusTracker
//
//  Created by Sagar Dagdu on 3/7/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SearchBar : UIViewRepresentable {
    
    @Binding var text : String
    @Binding var keyboardHeight: CGFloat
    var placeholder: String
    
    class Cordinator : NSObject, UISearchBarDelegate {
        
        @Binding var text : String
        @Binding var searchBarHeight: CGFloat

        
        init(text : Binding<String>, searchBarHeight: Binding<CGFloat>) {
            _text = text
            _searchBarHeight = searchBarHeight
            
            super.init()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                searchBarHeight = keyboardRectangle.height
            }
        }
        
        @objc func keyboardWillHide(_ notification: Notification) {
            searchBarHeight = 0
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text, searchBarHeight: $keyboardHeight)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.delegate = context.coordinator
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


