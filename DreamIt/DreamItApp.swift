//
//  DreamItApp.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI
import UIKit
import Firebase

@main
struct DreamItApp: App {
    
    init() {
        print("Configuring Firebase")
        FirebaseApp.configure()
        Firestore.firestore()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
