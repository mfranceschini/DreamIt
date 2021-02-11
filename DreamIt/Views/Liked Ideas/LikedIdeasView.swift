//
//  LikedIdeasVIew.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-04.
//

import SwiftUI

struct LikedIdeasView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> LikedViewController {
        let stb = UIStoryboard(name: "LikedIdeasStoryboard", bundle: nil)
        let vc  = stb.instantiateViewController(withIdentifier:"likedIdeasList") as! LikedViewController
        return vc
    }
    
    func updateUIViewController(_ uiViewController: LikedViewController, context: Context) {}
    
    typealias UIViewControllerType = LikedViewController
}
