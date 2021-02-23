//
//  SearchBar.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-19.
//

import SwiftUI
import Foundation

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.endEditing(true)
        }

        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
        
        func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.endEditing(true)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.isTranslucent = true
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = UIColor.init(white: colorScheme == .dark ? 0.5 : 0.1, alpha: 0.15)
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 1.0, alpha: 0.7)])
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}
