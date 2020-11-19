//
//  CloseModalLip.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-14.
//

import SwiftUI

struct CloseModalLip: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Rectangle()
            .frame(width: 40, height: 3)
            .cornerRadius(5)
            .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.5) : Color.gray.opacity(0.5))
    }
    
}
