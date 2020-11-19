//
//  LikedIdeasVIew.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-04.
//

import SwiftUI

struct LikedIdeasView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> LikedIdeasViewController {
        LikedIdeasViewController()
    }
    
    func updateUIViewController(_ uiViewController: LikedIdeasViewController, context: Context) {}
    
    typealias UIViewControllerType = LikedIdeasViewController
}
