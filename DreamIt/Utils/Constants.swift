//
//  Constants.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-16.
//

import Foundation
import SwiftUI

struct Constants {
    
    //App main background color
    static let background: [Color] = [
        Color(UIColor(red: 0.37, green: 0.22, blue: 0.56, alpha: 0.85)),
        Color(UIColor(red: 0.61, green: 0.31, blue: 0.62, alpha: 0.85)),
        Color(UIColor(red: 0.95, green: 0.49, blue: 0.71, alpha: 0.85)),
        Color(UIColor(red: 1.00, green: 0.42, blue: 0.44, alpha: 0.85)),
        Color(UIColor(red: 0.96, green: 0.44, blue: 0.24, alpha: 0.85))
    ]
    
    //Device screen size
    static let screenSize = UIScreen.main.bounds.size
    
    @Environment(\.colorScheme) static var colorScheme
    
    
}
